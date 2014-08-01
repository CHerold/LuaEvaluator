The client build includes all top-level GUI VIs and
templates into a single executable. The server build
creates a minimal server executable that includes only
a single boot VI, and loads all remaining VIs from
outside the executable.

By building a minimal server, it is possible to just
plop down a new revision of the development source
tree without having to rebuild and reinstall a new
executable. In addition, it becomes possible to
selectively upgrade VIs. For example, when a fix is
applied to just one VI, it is a little wasteful to
have to rebuild and reinstall. With a minimal server,
it suffices to replace just that one VI.

Disadvantages are a messier deployment and somewhat
longer load times. A further advantage is that the
relative paths remain the same as during development,
thus obviating the need to make path conditional
on whether the application is built or not. Lastly,
a big advantage is that the boring task of setting
up a build script for a server that includes
everything in a single executable can be skipped.

The executable of a minimal server must be built
with the same LabVIEW version as used to compile
the VIs the source tree. An easy way to ensure this
is to do a mass compile of the source tree with the
proper LabVIEW version for the platform on which
the deployment is being made.

When deploying a server on an isolated subnet as
described in the client-server manual, consider
making the VI source tree a subdirectory of the
server resources directory. This allows the
"Remote File Manager" GUI to be used for uploading
updated VIs.

The  files named "Client.bld" and "Server.bld" are
the Windows build scripts. The files named
"client_linux.bld" and "server_linux.bld" are the
Linux build scripts. Load them into the application
builder and adjust the name of the application and
the build paths as desired.

Under Windows, both build scripts create an installer
that includes an INI file from the "client files" and
"server files" subdirectory respectively.
Before building a Windows installer, make sure to
hit the "generate" product code button as found
under the "properties" dialog that can be started
from the "installer settings" tab of the application
builder. When installers are not given a unique
product code, they will mutually conflict.

For Linux, it is only possible to build an executable.
The LabVIEW runtime has to be installed separately. It
can be downloaded from the NI web site or ftp site. By
placing the labviewrc file (examples of which are also
contained in the "client files" and "server files"
directories) in the same directory as the executable,
the options therein will be applied when the client
starts. Any setting in a .labviewrc file in the home
directory of the user starting the application take
precendence over the labviewrc settings. This allows
the settings to be customised per user. In order to
force the loading of a particular rc file, start
the server or client executable with "-pref <rcfile>"
as command-line arguements. Make sure that the rc
files have unix format (lines end with a linefeed)
or else the configuration options might get ignored.
Note that the first part of the configuration keys
in the rc file must equal the name of the executable.
Therefore do not choose an executable name with a dot
in it (such as server.exe) because this will mess
up the key lookup.

To let the server executable find the source tree, it
must be provided with a path to the top-level server
VI. This path is stored in the "serverpath.txt" file
located in the application directory (the directory
containing the server executable). When this file is
not present on starting the server, the option will
be given to specify the top-level VI via a file dialog.

Some of the VIs in the source tree might make use of
library or instrumentation VIs. During development,
LabVIEW automatically searches for these VIs
in the vi.lib and instr.lib subdirectories of the
LabVIEW directory. However, when building a minimal
server, the LabVIEW runtime must be told where it
can look for these VIs. To do so, configure VI search
paths that point to the required VIs in either the
server.ini file (Windows) or the labviewrc file (Linux).
If storage space is no concern, the easiest solution is
to copy the entire vi.lib and instr.lib directories on
deployment instead of figuring out which VIs are
actually used and copying only those.

It should not be necessary to specify VI a search path
for any subVIs contained in the source tree since
LabVIEW VIs store relative paths to any custom subVIs
they reference. Thus, by keeping the relative paths in
the source tree constant when copying it over on
deployment, the runtime is able to find subVIs. Only
when a VI is not saved after one of its subVIs is
relocated can it occur that that subVI can no longer
be found. This is a further reason for doing a
mass compile first. One thing to be aware of is that
changing the case of a subVI or a directory that
contains it under Windows does not cause the LabVIEW
development environment to mark the using VI as
having changed because Windows file systems are
case independent. However, when copying over that
source tree to Linux, the case will matter and the
search for the subVI might fail.

Since the server has no user interface, it is
preferable to run it in the background. Under
Windows, this can be done by running the server
executable as a service. This has as further
advantage that it gets started when the machine
boots, and remains running when users log out.
The NI web site contains two documents that
describe how to do so. The first requires editing
the registry and makes use of a Microsoft tool,
the second makes use of the third-party tool

Creating a Windows NT Service Using LabVIEW
http://zone.ni.com/devzone/conceptd.nsf/webmain/A9B2FA96B851394586256B26006ECB98?opendocument

Running a LabVIEW Application as a Windows NT/2000/XP Service
http://digital.ni.com/public.nsf/3efedde4322fef19862567740067f3cc/21ba0f671a63a60386256cb4004df99b?OpenDocument

Of course, it is also possible to build a server
executable that includes all required VIs. See the
"organisation" appendix of the LuaVIEW documentation
to get an overview of all the dynamically loaded
VIs that must be included in the build. Note that
this is quite a bit of work without some automation
because the application builder allows only one
VI to be specified at a time. One option is to create
placeholder VIs that have bundles of dynamically
loaded VIs as subVI, and include those in the build
merely to get a bunch of VIs in one go: subVIs
are included automatically. An alternative is to
have a look at the Open G build tools. When
deploying a fat server, change the bootstrap script
such that it looks for the function VIs inside the
built executable when not running in development
mode.
