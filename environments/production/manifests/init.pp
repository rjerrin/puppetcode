node 'Jslm'  
{

include roles::ubase
#include roles::nfsshare
include roles::vm

}

node 'debian'
{
include roles::ubase

}

node 'astra'
{
include roles::ubase
}




