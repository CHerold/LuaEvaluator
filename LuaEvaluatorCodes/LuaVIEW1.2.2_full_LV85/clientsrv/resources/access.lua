-- BEWARE: this script configures passwords as plaintext.
-- When unauthorized persons have access to the server
-- machine, make sure that this file is not readable by them.

-- Setup warning/error logging and configure and enable remote access from clients.
run_task("warnings.lua")
lv.addcleanup(function() sig.stop("warnings") end)
run_task("errors.lua")
lv.addcleanup(function() sig.stop("errors") end)

-- Open and configure the server module. When done, clients can connect.
module=VI.open_module(resolve_VI_path("ClientSrv Server Module.vi","dynamic"),"","",{
["server name"]="Example",
-- The name of the server. It should be chosen to uniquely identify the
-- server. A good choice is to base the name on the experiment, setup, or
-- process being managed by the server.
["port number"]=3363,
-- Sets the TCP/IP port number on which the server will accept connections.
-- A good choice is the default port number for the VI-server protocol: 3363.
-- Multiple server instances running on a single machine will need to be
-- configured with different port numbers.
["access list"]={"+localhost"},
-- List of machine names or IP addresses from which clients are allowed or
-- disallowed connection access to the server. A leading "+" indicates that
-- connection is allowed. A leading "-" indicates that connection is
-- disallowed. It is possible to specify ranges of IP adresses using the *
-- wildcard. E.g. "+10.10.*" allows all machines whose IP adress begins
-- with 10.10. and "-*.foo.com" blocks all machines in the foo.com domain.
--
-- Make sure to specify at least one allowed entry that includes a valid
-- client machine or else it will be impossible to connect to the server.
-- It is advisable to specify and allow "+localhost" so as to allow
-- connections to the server using a client running on the same machine
-- as the server (e.g. in case of a network outage).
["observer password"]="",
-- This password is required when connecting a client to the server. Once
-- connected, the client can perform read-only (observer) operations on the
-- server. Multiple clients can be simultaneously connected to a single
-- server. For security, it is advisable to use an obscure password of at
-- least 6 characters. To bypass security, leave this field empty. The client
-- will still query for a password via a dialog, but this dialog can then simply
-- be OKed without entering a password.
["operator password"]="",
-- The password required to obtain operator access to the server which allows
-- for operations that change the state of the server. Only a single client may
-- be holding operator access at any one time. For security, it is advisable to
-- use an obscure password of at least 6 characters. To bypass security, leave
-- this field empty. The client will still query for a password via a dialog, but
-- this dialog can then simply be OKed without entering a password.
["access timeout"]=0,
-- Timeout in seconds for operator access. When no actions requiring operator
-- access are performed for longer than this timeout by the client holding the
-- current operator certificate, the server will revoke the certificate. This
-- provides extra security by automatically revoking operator access for
-- clients that are left unattended. To disable this feature, set the timeout
-- to zero.
["client version"]="",
-- When this string is not empty, the server only allows clients to connect
-- that pass an identical version string. This is useful when you deploy
-- multiple client versions that are mutually incompatible or backwards
-- incompatible: it can prevent an incompatible client from connecting.
--
-- On the client side, the version can be set in the global of identical
-- name found in clientsrv/glb_ClientSrv Globals.vi.
})
-- Make sure the module cleans itself up when this script is done.
lv.addcleanup(function() cleanup() module:close() end)

-- Preload served VIs for client performance at the expense of a some
-- extra server memory usage (optional).
open_served_VIs(".")

-- Basic initialisation is done. Start the "runlevels" initialisation task.
ok,err=lv.pcall(do_task,"runlevels.lua")
if not ok then
    msg.send("errors",err)
end
