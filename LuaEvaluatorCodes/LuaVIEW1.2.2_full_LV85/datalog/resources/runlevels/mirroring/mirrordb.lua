--#identifier "mirrordb"
--#class "<dir>"
--#defer
--#disallow_manual
--#hide
--#import "domirror.lua"
--#description "Configure, do, and redo a database mirror task."

domirror({
localdb="mirrordb", -- Name of the local taget database.
remotedb="testdb", -- Name of the remote source database.
machine="localhost", -- Remote machine name or IP address.
port=3363, -- Port on the remote machine to connect to.
password="", -- Observer password of the remote server.
tagdelay=5000, -- Delay between subsequent tags (ms).
reconnectdelay=60000, -- Delay between reconnection attempts (ms).
})
