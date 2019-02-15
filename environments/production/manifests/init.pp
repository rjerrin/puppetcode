node 'Jslm'  
{

include roles::ubase
include roles::nfsshare

}

node 'debian'
{
include roles::ubase

}

node 'astra'
{
include roles::ubase
}




