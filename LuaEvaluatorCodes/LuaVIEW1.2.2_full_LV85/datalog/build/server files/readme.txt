To complete the installation of the server, copy
the source tree and resources. To let the server
executable find the source tree, point it to the
top-level server VI. To do so, start the server
executable. It will complain about not finding
the path to the server VI. Hit "yes" and use
the file dialog to browse for the server VI.
To later change to a different server VI, edit
the path which is saved in the "serverpath.txt"
file in the application directory (the directory
containing the server executable) or delete
that file so as to again specify a path via the
file dialog.

The LabVIEW runtime must be told where it can look
for the library and instrumentation VIs used by
the server application. If storage space is no
concern, the easiest solution is to copy the
entire vi.lib and instr.lib directories from the
LabVIEW development environment and change the
viSearchPath setting in the Server.ini file to
point to these directories.

Since the server has no user interface, it is
preferable to run it in the background. Under
Windows, this can be done by running the server
executable as a service. This has as further
advantage that it gets started when the machine
boots, and remains running when users log out.

The NI web site contains two documents that
describe how to set up a service. The first
method requires editing the registry and makes
use of a Microsoft tool, the second method makes
use of the third-party tool.

Creating a Windows NT Service Using LabVIEW
http://zone.ni.com/devzone/conceptd.nsf/webmain/A9B2FA96B851394586256B26006ECB98?opendocument


Running a LabVIEW Application as a Windows NT/2000/XP Service
http://digital.ni.com/public.nsf/3efedde4322fef19862567740067f3cc/21ba0f671a63a60386256cb4004df99b?OpenDocument
