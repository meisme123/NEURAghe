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

class NuragheConfig(pulpConfig.Config):

  versions = {
    'apb_soc'    : 1,
    'mchan'      : 3,
    'eventUnit'  : 1,
    'or1k'       : 4,
    'soc'        : 3,
    'icache_ctrl': 1,
  }

  nbCluster = 1

  soc_peripherals_base = 0x1A100000

  soc_apb_base = soc_peripherals_base + 0x4000



  def __init__(self, decorators={}):
    super(NuragheConfig, self).__init__(decorators=decorators)

    self.soc = pulpConfig.Soc_v3_1(self)

    self.clusters = []

    for cid in range(0, self.nbCluster):
      cluster = pulpConfig.Cluster_v3(self)
      clusterConfig = cluster.getConfig()
      # Cluster configuration can be customized here
      cluster.updateConfig(clusterConfig)
      self.clusters.append(cluster)
