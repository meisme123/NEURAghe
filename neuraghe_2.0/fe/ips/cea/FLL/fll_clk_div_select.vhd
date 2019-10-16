--!
--! @file fll_clk_div_select.vhd
--! @brief Frequency Locked Clock Divider and Selector 
--! 
--! This block performs :
--! - division of the high speed DCO generated clock
--! - select among two sets of two frequencies, to be used for Fhigh and Flow, the final clock
--!
--! <B>
--! @n
--! This file is part of the Platform 2012 program,
--! a cooperation between STMicroelectronics and CEA.@n
--! Redistribution of this file to outside parties is
--! strictly prohibited without the written consent
--! of the module owner indicated below.@n
--! </B>
--! 
--! @par  Module owner: Ivan MIRO PANADES
--!       ivan.miro-panades@cea.fr
--! 
--! @par  Copyright (C) 2009 CEA
--! 
--! @par  Authors: Ivan MIRO PANADES
--!                Pascal VIVET
--! 
--! @par  Id: $Id: fll_clk_div_select.vhd 1 2014-01-15 16:11:08Z im219746 $
--! @par  Date: $Date: 2014-01-15 17:11:08 +0100 (Wed, 15 Jan 2014) $
--! @par  Revision: $Rev: 1 $
--!


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY common_cells_lib;
USE common_cells_lib.ALL;

ENTITY fll_clk_div_select IS
  GENERIC(
    CLK_DIV_AFTER_RESET : STD_LOGIC_VECTOR := "1000"  -- Value aplied to the muxes at reset 
  );
  PORT(
    clk          : IN  STD_LOGIC;                    -- Main clock (CVP)
    clk_dco      : IN  STD_LOGIC;                    -- clk generated by the VCO/DCO
    rst_n        : IN  STD_LOGIC;                    -- reset already synchronized within CVP-U
    rst_async_n  : IN  STD_LOGIC;                    -- hard reset
    cfg_div      : IN  STD_LOGIC_VECTOR(3 downto 0); -- config to select the DCO division factor (2^0 to 2^15)
    test_mode    : IN  STD_LOGIC;
    clk_out      : OUT STD_LOGIC;                    -- generated clock
    valid_clk    : OUT STD_LOGIC;                    -- output control to indicate that generated clock is now stable
    current_div  : OUT STD_LOGIC_VECTOR(3 downto 0)  -- current division factor
  ); 
END fll_clk_div_select;

ARCHITECTURE rtl of fll_clk_div_select IS

  TYPE   T_MUX IS ARRAY (0 to 1) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL cfg_div_r : T_MUX;
  SIGNAL cfg_div_s : T_MUX;

  SIGNAL clk_div   : STD_LOGIC_VECTOR(1 to 16);    -- clk_dco divided by 2^1 to 2^16
  SIGNAL clk_div_s : STD_LOGIC_VECTOR(1 to 15);    -- clk signals after mux for test
  
  SIGNAL clk0_12, clk0_34, clk0_56, clk0_78, clk0_910, clk0_1112, clk0_1314, clk0_1516 : STD_LOGIC;
  SIGNAL clk0_1234, clk0_5678, clk0_9101112, clk0_13141516 : STD_LOGIC;
  SIGNAL clk0_12345678, clk0_910111213141516, clk0_out, clk0_out_n : STD_LOGIC;
  
  SIGNAL clk1_12, clk1_34, clk1_56, clk1_78, clk1_910, clk1_1112, clk1_1314, clk1_1516 : STD_LOGIC;
  SIGNAL clk1_1234, clk1_5678, clk1_9101112, clk1_13141516 : STD_LOGIC;
  SIGNAL clk1_12345678, clk1_910111213141516, clk1_out, clk1_out_n : STD_LOGIC;
  
  SIGNAL clk_out_i       : STD_LOGIC;
  SIGNAL selected0_async : STD_LOGIC;
  SIGNAL selected1_async : STD_LOGIC;
  SIGNAL selected0_sync  : STD_LOGIC;
  SIGNAL selected1_sync  : STD_LOGIC;
  
  SIGNAL current_mux_r : STD_LOGIC;
  SIGNAL current_mux_s : STD_LOGIC;

  SIGNAL current_mux_int   : NATURAL;
  SIGNAL current_mux_int_n : NATURAL;

  COMPONENT fll_fdiv2 PORT(    -- used to be the C12T32_LL_FDIV2 cell from FLL library, standard flip-flop now
    RST_N       : IN  STD_LOGIC;
    CLKI        : IN  STD_LOGIC;
    CLKO        : OUT STD_LOGIC
    );
  END COMPONENT;
    
  COMPONENT fll_clk_select 
    PORT(
      rst_n       : IN  STD_LOGIC;
      clk_0       : IN  STD_LOGIC;
      clk_1       : IN  STD_LOGIC;
      select_clk  : IN  STD_LOGIC;
      test_mode   : IN  STD_LOGIC;
      clk_out     : OUT STD_LOGIC;
      selected0   : OUT STD_LOGIC;
      selected1   : OUT STD_LOGIC
    );
  END COMPONENT;
    
  COMPONENT clock_mux2 PORT(    -- generic cell, remapped on CLK library using C12T32_LL_CNMUX21X17 cell
      clk_select  : IN  STD_LOGIC;
      clk_in0     : IN  STD_LOGIC;
      clk_in1     : IN  STD_LOGIC;
      clk_out     : OUT STD_LOGIC
    );
  END COMPONENT;

  COMPONENT synchronizer IS
    GENERIC(
      RESET_VALUE : STD_LOGIC := '0'  -- OUTPUT VALUE AT RESET 
    );
    PORT(
      rst_n     : IN  STD_LOGIC;
      clk       : IN  STD_LOGIC;
      data_in   : IN  STD_LOGIC;
      data_out  : OUT STD_LOGIC
    );
  END COMPONENT;

BEGIN

  --------------------------------------------------------------------------------
  -- Clock mux for testability
  --------------------------------------------------------------------------------
  clk_test_gen: for i in 1 to 15 generate 
    clk_mux_for_test_u : clock_mux2 
      PORT MAP(
        clk_in0     => clk_div(i),
        clk_in1     => clk_dco   , -- when in test mode clk_dco input port has already became the test clock thanks to an upper level mux
        clk_select  => test_mode ,
        clk_out     => clk_div_s(i)
      );
  end generate clk_test_gen;

  --------------------------------------------------------------------------------
  -- CLOCK division : chain of dividers
  --------------------------------------------------------------------------------
  
  -- clk_dco is maximum 4GHz
  
  u_div1  : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_dco,       CLKO => clk_div(1));   -- max 2 GHz
  u_div2  : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(1),  CLKO => clk_div(2));   -- max 1 GHz
  u_div3  : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(2),  CLKO => clk_div(3));   -- max 500 MHz
  u_div4  : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(3),  CLKO => clk_div(4));   -- max 250 MHz
  u_div5  : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(4),  CLKO => clk_div(5));   -- max 125 MHz
  u_div6  : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(5),  CLKO => clk_div(6));   -- max 62.5 MHz
  u_div7  : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(6),  CLKO => clk_div(7));   -- max 31.25 MHz
  u_div8  : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(7),  CLKO => clk_div(8));   -- max 15.6 MHz
  u_div9  : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(8),  CLKO => clk_div(9));   -- max 8 MHz
  u_div10 : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(9),  CLKO => clk_div(10));  -- max 4 MHz
  u_div11 : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(10), CLKO => clk_div(11));  -- max 2 MHz
  u_div12 : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(11), CLKO => clk_div(12));  -- max 1 MHz
  u_div13 : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(12), CLKO => clk_div(13));  -- max 500 KHz
  u_div14 : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(13), CLKO => clk_div(14));  -- max 250 KHz
  u_div15 : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(14), CLKO => clk_div(15));  -- max 125 KHz
  u_div16 : fll_fdiv2 PORT MAP (RST_N => rst_async_n, CLKI => clk_div_s(15), CLKO => clk_div(16));  -- max 62 KHz


  --------------------------------------------------------------------------------
  -- CLOCK selection : for clock 0 
  --------------------------------------------------------------------------------

  u_clk0_mux0 : clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(0), clk_in0 => clk_div(1),  clk_in1 => clk_div(2),  clk_out => clk0_12);
  u_clk0_mux1 : clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(0), clk_in0 => clk_div(3),  clk_in1 => clk_div(4),  clk_out => clk0_34);
  u_clk0_mux2 : clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(0), clk_in0 => clk_div(5),  clk_in1 => clk_div(6),  clk_out => clk0_56);
  u_clk0_mux3 : clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(0), clk_in0 => clk_div(7),  clk_in1 => clk_div(8),  clk_out => clk0_78);
  u_clk0_mux4 : clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(0), clk_in0 => clk_div(9),  clk_in1 => clk_div(10), clk_out => clk0_910);
  u_clk0_mux5 : clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(0), clk_in0 => clk_div(11), clk_in1 => clk_div(12), clk_out => clk0_1112);
  u_clk0_mux6 : clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(0), clk_in0 => clk_div(13), clk_in1 => clk_div(14), clk_out => clk0_1314);
  u_clk0_mux7 : clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(0), clk_in0 => clk_div(15), clk_in1 => clk_div(16), clk_out => clk0_1516);

  u_clk0_mux8 : clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(1), clk_in0 => clk0_12,   clk_in1 => clk0_34,   clk_out => clk0_1234);
  u_clk0_mux9 : clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(1), clk_in0 => clk0_56,   clk_in1 => clk0_78,   clk_out => clk0_5678);
  u_clk0_mux10: clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(1), clk_in0 => clk0_910,  clk_in1 => clk0_1112, clk_out => clk0_9101112);
  u_clk0_mux11: clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(1), clk_in0 => clk0_1314, clk_in1 => clk0_1516, clk_out => clk0_13141516);

  u_clk0_mux12: clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(2), clk_in0 => clk0_1234,    clk_in1 => clk0_5678,     clk_out => clk0_12345678);
  u_clk0_mux13: clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(2), clk_in0 => clk0_9101112, clk_in1 => clk0_13141516, clk_out => clk0_910111213141516);

  u_clk0_mux14: clock_mux2 PORT MAP (clk_select => cfg_div_r(0)(3), clk_in0 => clk0_12345678, clk_in1 => clk0_910111213141516, clk_out => clk0_out);

  clk0_out_n <= not clk0_out;

  --------------------------------------------------------------------------------
  -- CLOCK selection : for clock 1 
  --------------------------------------------------------------------------------

  u_clk1_mux0 : clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(0), clk_in0 => clk_div(1),  clk_in1 => clk_div(2),  clk_out => clk1_12);
  u_clk1_mux1 : clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(0), clk_in0 => clk_div(3),  clk_in1 => clk_div(4),  clk_out => clk1_34);
  u_clk1_mux2 : clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(0), clk_in0 => clk_div(5),  clk_in1 => clk_div(6),  clk_out => clk1_56);
  u_clk1_mux3 : clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(0), clk_in0 => clk_div(7),  clk_in1 => clk_div(8),  clk_out => clk1_78);
  u_clk1_mux4 : clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(0), clk_in0 => clk_div(9),  clk_in1 => clk_div(10), clk_out => clk1_910);
  u_clk1_mux5 : clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(0), clk_in0 => clk_div(11), clk_in1 => clk_div(12), clk_out => clk1_1112);
  u_clk1_mux6 : clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(0), clk_in0 => clk_div(13), clk_in1 => clk_div(14), clk_out => clk1_1314);
  u_clk1_mux7 : clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(0), clk_in0 => clk_div(15), clk_in1 => clk_div(16), clk_out => clk1_1516);

  u_clk1_mux8 : clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(1), clk_in0 => clk1_12,   clk_in1 => clk1_34,   clk_out => clk1_1234);
  u_clk1_mux9 : clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(1), clk_in0 => clk1_56,   clk_in1 => clk1_78,   clk_out => clk1_5678);
  u_clk1_mux10: clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(1), clk_in0 => clk1_910,  clk_in1 => clk1_1112, clk_out => clk1_9101112);
  u_clk1_mux11: clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(1), clk_in0 => clk1_1314, clk_in1 => clk1_1516, clk_out => clk1_13141516);

  u_clk1_mux12: clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(2), clk_in0 => clk1_1234,    clk_in1 => clk1_5678,     clk_out => clk1_12345678);
  u_clk1_mux13: clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(2), clk_in0 => clk1_9101112, clk_in1 => clk1_13141516, clk_out => clk1_910111213141516);

  u_clk1_mux14: clock_mux2 PORT MAP (clk_select => cfg_div_r(1)(3), clk_in0 => clk1_12345678, clk_in1 => clk1_910111213141516, clk_out => clk1_out);

  clk1_out_n <= not clk1_out;

  --------------------------------------------------------------------------------
  -- glitch free final selection between clock high and clock low
  --------------------------------------------------------------------------------

  u_clk_select : fll_clk_select 
    PORT MAP (
      rst_n       => rst_async_n,
      clk_0       => clk0_out_n,
      clk_1       => clk1_out_n,
      select_clk  => current_mux_r,
      test_mode   => test_mode,
      clk_out     => clk_out_i,
      selected0   => selected0_async,
      selected1   => selected1_async
    );

  -- Synchronizers
  u_Select0_sync : synchronizer 
    GENERIC MAP (
      RESET_VALUE => '0'
    )
    PORT MAP(
      rst_n     => rst_n,
      clk       => clk,
      data_in   => selected0_async,
      data_out  => selected0_sync 
    );

  u_Select1_sync : synchronizer 
    GENERIC MAP (
      RESET_VALUE => '0'
    )
    PORT MAP(
      rst_n     => rst_n,
      clk       => clk,
      data_in   => selected1_async,
      data_out  => selected1_sync 
    );

  pClock : process(rst_n,clk)
    begin
      if (rst_n='0') then
        current_mux_r <= '0';
        cfg_div_r(0)  <= CLK_DIV_AFTER_RESET;
        cfg_div_r(1)  <= CLK_DIV_AFTER_RESET;
      elsif(clk='1' and clk'event) then
        current_mux_r <= current_mux_s;
        cfg_div_r(0)  <= cfg_div_s(0) ;
        cfg_div_r(1)  <= cfg_div_s(1) ;
      end if;
    end process;

  current_mux_int   <= 1 when current_mux_r = '1' else 0;
  current_mux_int_n <= 0 when current_mux_r = '1' else 1;

  pUpdateMux : process(cfg_div_r, current_mux_r, cfg_div, current_mux_int, current_mux_int_n)
    begin
      cfg_div_s     <= cfg_div_r;
      current_mux_s <= current_mux_r;
      --The value required is deifferent than the current one?
      if (cfg_div /= cfg_div_r(current_mux_int)) then
        --Store the new value into the other mux_selector (not the current one)
        cfg_div_s(current_mux_int_n)  <= cfg_div;
        --Select the new 'current_mux' 
        current_mux_s <= not current_mux_r;
      end if;
    end process;

  --Outputs
  valid_clk   <= ((not current_mux_r) AND selected0_sync) OR (current_mux_r AND selected1_sync);
  current_div <=  cfg_div_r(current_mux_int);

  -- We add a small delay for RTL simulation :
  -- => to avoid delta delay problem in the synchronous unit, clocked by this generated clock
  clk_out <= clk_out_i after 10 ps;
  
END rtl;