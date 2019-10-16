# 
# Copyright (C) 2015 ETH Zurich and University of Bologna
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#
# Authors: Germain Haugou (germain.haugou@gmail.com)
#

import configs.pulp.PulpConfigCommon as pulpConfig

class FulmineConfig(pulpConfig.Config):

  versions = {
    'apb_soc'    : 1,
    'mchan'      : 5,
    'udma'       : 1,
    'eventUnit'  : 1,
    'or1k'       : 5,
    'soc'        : 4,
    'hwce'       : 3,
    'icache_ctrl': 1,
  }

  imaps = {
    'udma0'   : 10,
    'udma1'   : 11,
    'udma2'   : 12,
    'udma3'   : 13,
    'udma4'   : 14,
    'udma5'   : 15,
    'udma6'   : 16,
    'udma7'   : 17,
  }

  properties = {
    'hasUart'       : 1
  }

  nbCluster = 1

  soc_peripherals_base = 0x1A100000

  soc_apb_base = soc_peripherals_base + 0x3000

  def __init__(self, decorators):
    super(FulmineConfig, self).__init__(decorators=decorators)

    self.soc = pulpConfig.Soc_v4(self)


    self.clusters = []

    for cid in range(0, self.nbCluster):
      cluster = pulpConfig.Cluster_v4(self)
      self.clusters.append(cluster)