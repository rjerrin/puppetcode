node 'Jslm'  
{

include roles::ubase
#include roles::nfsshare
include roles::vm
include roles::torsvc

}

node 'debian'

{

include roles::ubase


}

node 'astra'
{

include roles::ubase

}

node 'fbsd'
{

include roles::fbase

}

node 'ubuntu'
{

include roles::ubase

}

node 'kali.test.dev'

{

include roles::ubase

}

node 'puppetmaster.bsd.dev'
{
  include roles::fbase
  include roles::torsvc
}



