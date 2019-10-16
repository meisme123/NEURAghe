/* 
 * ConvLayer.h
 * Francesco Conti <f.conti@unibo.it>
 *
 * Copyright (C) 2015 ETH Zurich, University of Bologna
 * All rights reserved.
 *
 * This software may be modified and distributed under the terms
 * of the BSD license.  See the LICENSE file for details.
 */

#ifndef CONVLAYER_H
#define CONVLAYER_H

#ifndef TYPES_H
#include "types.h"
#endif
      
/**
 *  Data structure definining a convolutional layer for a ConvNet. Input is
 *  taken from the location pointed by *x and output is produced at *y; thus
 *  it is possible to retarget the input at runtime with no data movement by
 *  changing the *x pointer.
 *  The ConvLayer computes the output of a convolutional network layer with
 *  3d inputs and outputs (an array of 2d feature maps).
 */
typedef struct {
    const char *name;
    int n_in_feat;     ///< number of input feature maps.
    int n_out_feat;    ///< number of output feature maps.
    int filter_size;   ///< size of the weight kernel.
    int height;        ///< height of the input feature maps.
    int width;         ///< width of the input feature maps.
    int activation;    ///< activation type.
    int parallel_type; ///< parallelization type.
    data_t *w;         ///< pointer to the weights.
    data_t *b;         ///< pointer to the biases.
    data_t *x;         ///< pointer to the input feature maps.
    data_t *y;         ///< pointer to the output feature maps.
    data_t *loc_w0;        ///< pointer to the weights.
    data_t *loc_w1;        ///< pointer to the weights.
    data_t *loc_b;         ///< pointer to the biases.
    data_t *loc_x0;
    data_t *loc_x1;
    data_t *loc_y0;
    data_t *loc_y1;
    data_t *loc_y2;
    int tiling_max_nof;
    int tiling_max_nif;
    int tiling_max_height;
    int tiling_max_width;
    int ntile_nof;
    int ntile_nif;
    int ntile_h;
    int ntile_w;
    void *tile_grid_nof;
    void *tile_grid_nif;
    void *tile_grid_h;
    void *tile_grid_w;
    data_t *loc_x_fe;
    data_t *loc_x_ex;
    data_t *loc_w_fe;
    data_t *loc_w_ex;
    data_t *loc_y_fe;
    data_t *loc_y_ex;
    data_t *loc_y_wb;
    unsigned char ntile_full_nof;
    unsigned char ntile_full_nif;
    unsigned char ntile_full_h;
    unsigned char ntile_full_w;
    unsigned char tlast_nof;
    unsigned char tlast_nif;
    unsigned char tlast_h;
    unsigned char tlast_w;
    unsigned qf;

#ifdef PLP_RT
    void (*convHandler)(short int *W, short int *x, short int *y, int h, int w, int nif, int wof, int config1);
    data_t *loc_x[2];
    data_t *loc_w[2];
    data_t *loc_y[2];
    int prevNof;
    int prevOh;
    int prevOw;

    int prev_aa;
    int prev_ii;
    int prev_jj;
    int _h;
    int _w;
    int dbIndex;
    int yDbIndex;
    int finished;
    int _nof;
    int _nif;
    int constantDmaId;
    int ongoingOf;
    int aa;
    int bb;
    int ii;
    int jj;
    int flushY;
    int exit;
#endif

} ConvLayer;

ConvLayer *ConvLayer_new(
#ifdef CCN_NOALLOC
  ConvLayer *layer,
#endif
  const char *name,
  data_t *w,
  data_t *b,
  data_t *x,
  data_t *y,
  data_t *loc_x0,
  data_t *loc_x1,
  data_t *loc_y0,
  data_t *loc_y1,
  data_t *loc_y2,
  data_t *loc_w0,
  data_t *loc_w1,
  int n_out_feat,
  int n_in_feat,
  int height,
  int width,
  int filter_size,
  int activation,
  int parallel_type,
  int tiling_max_nof,
  int tiling_max_nif,
  int tiling_max_height,
  int tiling_max_width,
  unsigned qf
);
void ConvLayer_delete(ConvLayer *layer);
void ConvLayer_exec(ConvLayer *layer);

#endif /* CONVLAYER_H */
