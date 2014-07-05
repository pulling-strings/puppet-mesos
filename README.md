# Intro 

Puppet Module for setting up Mesos clusters.

# Usage

On the master side:

```puppet
$hosts = {
  '192.168.1.10' => 'master.local master',
  '192.168.1.11' => 'slave.local slave',
}

node 'master.local' {
  class{'mesos::master':
    ip => '192.168.1.10'
  }

  class{'mesos::hosts':
    hosts => $hosts
  }

  class{'mesos::hadoop::hdfs':
    name_node      => true,
    namenode_hosts => ['master.local'],
    master         => 'master.local'
  }

  include 'mesos::hadoop::jobtracker'
  include 'mesos::hadoop::testing'
}
```
On the slave side:

```puppet
node 'slave.local' {
  class{'mesos::slave':
    ip => '192.168.1.10',
    resources  => 'ports:[30000-50000];cpus:2;mem:1048;disk:20000'
  }

  class{'mesos::hosts':
    hosts => $hosts
  }

  class{'mesos::hadoop::hdfs':
    name_node       => false,
    namenode_hosts  => ['master.local'],
    master          => 'master.local'
  }
}
```

# Copyright and license

Copyright [2014] [Ronen Narkis]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.

You may obtain a copy of the License at:

  [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
