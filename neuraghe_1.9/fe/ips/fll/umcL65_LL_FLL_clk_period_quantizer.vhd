-------------------------------------------------------------------------------
-- Title      : umcL65 Frequency Locked Loop Digital Controlled Oscillator 
-- Project    : PULP 65nm
-------------------------------------------------------------------------------
-- File       : umcL65_LL_FLL_clk_period_quantizer.vhd
-- Author     : David Bellasi  <bellasi@ee.ethz.ch>
-- Company    : Integrated Systems Laboratory, ETH Zurich
-- Created    : 2015-03-18
-- Last update: 2015-04-02
-- Platform   : ModelSim (simulation), Synopsys (synthesis)
-- Standard   : 
-------------------------------------------------------------------------------
-- Description: Measures how many DCO output clock periods fit into one
--              (or more) reference clock period(s).
--
--              The result is effectively a quantized version of the
--              reference clock period, where the quantization step is the
--              period of the DCo output clock.
--
--              The implementation is a simple counter clocked by the DCO
--              output clock. The counter runs for one or more ref. clock
--              periods.
--
--              NOTE: The counting starts at the falling edge of the ref clock
--                    in order to obtain a shorter delay between measurement
--                    and loop update.
-------------------------------------------------------------------------------
-- Copyright (c) 2015 Integrated Systems Laboratory, ETH Zurich
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author              Description
-- 2014-01-15  1.0      Ivan MIRO PANADES   Original version by CEA
--                                          (ivan.miro-panades@cea.fr)
-- 2015-03-18  2.0      bellasid            Ported to UMC 65nm node,
--                                          modified for PULP 65nm
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--LIBRARY common_cells_lib;
--USE common_cells_lib.ALL;

entity umcL65_LL_FLL_clk_period_quantizer is
  generic(
    COUNTER_WIDTH : natural := 14
    );
  port(
    clk_dco : in  std_logic;            -- clk generated by the VCO/DCO
    clk_ref : in  std_logic;            -- reference clk
    rst_dco : in  std_logic;            -- hard reset
    enable  : in  std_logic;
    counter : out std_logic_vector(COUNTER_WIDTH-1 downto 0)  -- counter value, send back to control
    );
end umcL65_LL_FLL_clk_period_quantizer;

architecture rtl of umcL65_LL_FLL_clk_period_quantizer is

  ----------------------------------------------------------------------
  -- Signals/contants declarations -------------------------------------
  ----------------------------------------------------------------------

  signal quant_counter, quant_counter_next           : unsigned(COUNTER_WIDTH-1 downto 0);
  signal quant_counter_keep, quant_counter_keep_next : unsigned(COUNTER_WIDTH-1 downto 0);

  signal ref_edge, ref_edge_0, ref_edge_1, ref_edge_2, ref_edge_3 : std_logic;


begin

  --------------------------------------------------------------------------------
  -- detect falling edge on the ref clk
  --------------------------------------------------------------------------------

  process (clk_dco, rst_dco)
  begin
    if rst_dco = '0' then
      ref_edge_0 <= '0';
      ref_edge_1 <= '0';
      ref_edge_2 <= '0';
      ref_edge_3 <= '0';
    elsif clk_dco = '1' and clk_dco'event then
      if enable = '1' then
        ref_edge_0 <= clk_ref;
        ref_edge_1 <= ref_edge_0;
        ref_edge_2 <= ref_edge_1;
        ref_edge_3 <= ref_edge_2;
      end if;
    end if;
  end process;

  ref_edge <= (not ref_edge_2) and ref_edge_3;


  --------------------------------------------------------------------------------
  -- start counting the dco cycles between two falling ref edges
  --------------------------------------------------------------------------------

  process (quant_counter, ref_edge)
  begin
    quant_counter_next <= quant_counter+1;
    if quant_counter = 2**(quant_counter'length)-1 then  -- avoid counter overflow
      quant_counter_next <= quant_counter;
    end if;
    if ref_edge = '1' then
      quant_counter_next <= (others => '0');
    end if;
  end process;

  quant_counter_keep_next <= quant_counter;

  process (clk_dco, rst_dco)
  begin
    if rst_dco = '0' then
      quant_counter      <= (others => '0');
      quant_counter_keep <= (others => '0');
    elsif clk_dco = '1' and clk_dco'event then  -- max freq ~ 1 GHz
      if enable = '1' then
        quant_counter <= quant_counter_next;
      end if;
      if enable = '1' and ref_edge = '1' then
        quant_counter_keep <= quant_counter_keep_next;
      end if;
    end if;
  end process;


  -- final counter value (can savely be sampled in the ref clock domain at the
  -- rising edge of the ref clock since the counter is updated at the falling
  -- edge of the ref clock)
  counter <= std_logic_vector(quant_counter_keep);




end rtl;
