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




