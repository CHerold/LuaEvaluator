<?xml version='1.0'?>
<Project Type="Project" LVVersion="8508002">
   <Item Name="My Computer" Type="My Computer">
      <Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
      <Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
      <Property Name="server.tcp.enabled" Type="Bool">false</Property>
      <Property Name="server.tcp.port" Type="Int">0</Property>
      <Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
      <Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
      <Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
      <Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
      <Property Name="specify.custom.address" Type="Bool">false</Property>
      <Item Name="Dynamic VIs" Type="Folder">
         <Item Name="tui_LuaVIEW Task Manager.vi" Type="VI" URL="luaview/tui_LuaVIEW Task Manager.vi"/>
         <Item Name="ui_LuaVIEW Task Console.vit" Type="VI" URL="luaview/dynamic/ui_LuaVIEW Task Console.vit"/>
         <Item Name="tui_LuaVIEW Function Manager.vi" Type="VI" URL="luaview/tui_LuaVIEW Function Manager.vi"/>
         <Item Name="ui_LuaVIEW Show Function Documentation.vit" Type="VI" URL="luaview/dynamic/ui_LuaVIEW Show Function Documentation.vit"/>
         <Item Name="tui_ClientSrv Remote File Manager.vi" Type="VI" URL="clientsrv/tui_ClientSrv Remote File Manager.vi"/>
         <Item Name="tui_DataLog Live Tag Chart.vit" Type="VI" URL="datalog/tui_DataLog Live Tag Chart.vit"/>
         <Item Name="tui_DataLog Live Tag Table.vit" Type="VI" URL="datalog/tui_DataLog Live Tag Table.vit"/>
         <Item Name="tui_DataLog Log Book.vit" Type="VI" URL="datalog/tui_DataLog Log Book.vit"/>
         <Item Name="tui_DataLog Log Graph.vit" Type="VI" URL="datalog/tui_DataLog Log Graph.vit"/>
         <Item Name="tui_DataLog Log Table.vi" Type="VI" URL="datalog/tui_DataLog Log Table.vi"/>
         <Item Name="ui_Datalog Time Graph.vit" Type="VI" URL="datalog/dynamic/ui_Datalog Time Graph.vit"/>
         <Item Name="ui_Datalog XY Graph.vit" Type="VI" URL="datalog/dynamic/ui_Datalog XY Graph.vit"/>
         <Item Name="tui_DataLog Tag Manager.vi" Type="VI" URL="datalog/tui_DataLog Tag Manager.vi"/>
         <Item Name="tui_Datalog Tag Subset Editor.vi" Type="VI" URL="datalog/tui_Datalog Tag Subset Editor.vi"/>
      </Item>
      <Item Name="Support Files" Type="Folder">
         <Item Name="Client.ini" Type="Document" URL="datalog/build/client files/Client.ini"/>
      </Item>
      <Item Name="ClientSrv Client.vi" Type="VI" URL="clientsrv/ClientSrv Client.vi"/>
      <Item Name="Dependencies" Type="Dependencies">
         <Item Name="vi.lib" Type="Folder">
            <Item Name="compatReturnToEnter.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatReturnToEnter.vi"/>
            <Item Name="eventvkey.ctl" Type="VI" URL="/&lt;vilib&gt;/event_ctls.llb/eventvkey.ctl"/>
            <Item Name="compatOverwrite.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatOverwrite.vi"/>
            <Item Name="Set Busy.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/cursorutil.llb/Set Busy.vi"/>
            <Item Name="Set Cursor.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/cursorutil.llb/Set Cursor.vi"/>
            <Item Name="Set Cursor (Cursor ID).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/cursorutil.llb/Set Cursor (Cursor ID).vi"/>
            <Item Name="Set Cursor (Icon Pict).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/cursorutil.llb/Set Cursor (Icon Pict).vi"/>
            <Item Name="Unset Busy.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/cursorutil.llb/Unset Busy.vi"/>
            <Item Name="Merge Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Merge Errors.vi"/>
            <Item Name="System Exec.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/system.llb/System Exec.vi"/>
            <Item Name="compatFileDialog.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatFileDialog.vi"/>
            <Item Name="Open URL in Default Browser.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/browser.llb/Open URL in Default Browser.vi"/>
            <Item Name="Open URL in Default Browser (string).vi" Type="VI" URL="/&lt;vilib&gt;/Platform/browser.llb/Open URL in Default Browser (string).vi"/>
            <Item Name="Open URL in Default Browser core.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/browser.llb/Open URL in Default Browser core.vi"/>
            <Item Name="Open URL in Default Browser (path).vi" Type="VI" URL="/&lt;vilib&gt;/Platform/browser.llb/Open URL in Default Browser (path).vi"/>
            <Item Name="Path to URL.vi" Type="VI" URL="/&lt;vilib&gt;/printing/PathToURL.llb/Path to URL.vi"/>
            <Item Name="Escape Characters for HTTP.vi" Type="VI" URL="/&lt;vilib&gt;/printing/PathToURL.llb/Escape Characters for HTTP.vi"/>
            <Item Name="compatReadText.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatReadText.vi"/>
            <Item Name="compatWriteText.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatWriteText.vi"/>
            <Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
            <Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
         </Item>
         <Item Name="Client.rtm" Type="Document" URL="clientsrv/Client.rtm"/>
         <Item Name="re_Edit Remote File.vi" Type="VI" URL="clientsrv/subvis/private/re_Edit Remote File.vi"/>
         <Item Name="ClientSrv Server File Manipulation_srv.ctl" Type="VI" URL="clientsrv/served/ClientSrv Server File Manipulation_srv.ctl"/>
         <Item Name="t_ClientSrv Access Levels.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Access Levels.ctl"/>
         <Item Name="glb_ClientSrv Globals.vi" Type="VI" URL="clientsrv/subvis/private/glb_ClientSrv Globals.vi"/>
         <Item Name="obj_ClientSrv Client Access State.vi" Type="VI" URL="clientsrv/objects/obj_ClientSrv Client Access State.vi"/>
         <Item Name="t_ClientSrv Client Access State Methods.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Client Access State Methods.ctl"/>
         <Item Name="obj_ClientSrv Connection State.vi" Type="VI" URL="clientsrv/objects/obj_ClientSrv Connection State.vi"/>
         <Item Name="t_ClientSrv Connection State Methods.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Connection State Methods.ctl"/>
         <Item Name="ClientSrv Server Access_srv.ctl" Type="VI" URL="clientsrv/served/ClientSrv Server Access_srv.ctl"/>
         <Item Name="Library Resolve VI Path.vi" Type="VI" URL="library/file handling/Library Resolve VI Path.vi"/>
         <Item Name="Library Resolve Toolkit Directory.vi" Type="VI" URL="library/file handling/Library Resolve Toolkit Directory.vi"/>
         <Item Name="Library Toolkit Path.vi" Type="VI" URL="library/file handling/Library Toolkit Path.vi"/>
         <Item Name="t_ClientSrv Server Access Methods.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Server Access Methods.ctl"/>
         <Item Name="ClientSrv Digest Password.vi" Type="VI" URL="clientsrv/subvis/private/ClientSrv Digest Password.vi"/>
         <Item Name="Library Remote Call Error Merger.vi" Type="VI" URL="library/error handling/Library Remote Call Error Merger.vi"/>
         <Item Name="Library Open VI Ref Error Clarifier.vi" Type="VI" URL="library/error handling/Library Open VI Ref Error Clarifier.vi"/>
         <Item Name="glb_Library Configuration Globals.vi" Type="VI" URL="library/glb_Library Configuration Globals.vi"/>
         <Item Name="Library Error Code.vi" Type="VI" URL="library/error handling/Library Error Code.vi"/>
         <Item Name="et_Library Error Code Enum.ctl" Type="VI" URL="library/typedefs/et_Library Error Code Enum.ctl"/>
         <Item Name="ui_ClientSrv Query Access Password.vi" Type="VI" URL="clientsrv/subvis/private/dialogs/ui_ClientSrv Query Access Password.vi"/>
         <Item Name="t_ClientSrv Query Access Password States.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Query Access Password States.ctl"/>
         <Item Name="Library Show Help.vi" Type="VI" URL="library/gui/Library Show Help.vi"/>
         <Item Name="Libary Persist Position and Controls.vi" Type="VI" URL="library/persistence/Libary Persist Position and Controls.vi"/>
         <Item Name="Library Absolve Path.vi" Type="VI" URL="library/file handling/Library Absolve Path.vi"/>
         <Item Name="Library New Path.vi" Type="VI" URL="library/file handling/Library New Path.vi"/>
         <Item Name="Library Collect VI Control Refnums.vi" Type="VI" URL="library/persistence/Library Collect VI Control Refnums.vi"/>
         <Item Name="Library Save or Load Referenced Controls.vi" Type="VI" URL="library/persistence/Library Save or Load Referenced Controls.vi"/>
         <Item Name="Library New File.vi" Type="VI" URL="library/file handling/Library New File.vi"/>
         <Item Name="Library Open File.vi" Type="VI" URL="library/file handling/Library Open File.vi"/>
         <Item Name="Library Format Word List.vi" Type="VI" URL="library/string handling/Library Format Word List.vi"/>
         <Item Name="ClientSrv Set Client Title.vi" Type="VI" URL="clientsrv/subvis/private/ClientSrv Set Client Title.vi"/>
         <Item Name="ClientSrv Remote File Dialog.vi" Type="VI" URL="clientsrv/subvis/ClientSrv Remote File Dialog.vi"/>
         <Item Name="t_ClientSrv Remote File Dialog States.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Remote File Dialog States.ctl"/>
         <Item Name="ClientSrv Tag to Path.vi" Type="VI" URL="clientsrv/subvis/private/ClientSrv Tag to Path.vi"/>
         <Item Name="t_ClientSrv Tree Controller Methods.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Tree Controller Methods.ctl"/>
         <Item Name="Library Log Error to Window.vi" Type="VI" URL="library/error handling/Library Log Error to Window.vi"/>
         <Item Name="Library Time.vi" Type="VI" URL="library/Library Time.vi"/>
         <Item Name="ui_Library Error Log Window.vi" Type="VI" URL="library/error handling/ui_Library Error Log Window.vi"/>
         <Item Name="re_ClientSrv Tree Controller.vi" Type="VI" URL="clientsrv/subvis/private/re_ClientSrv Tree Controller.vi"/>
         <Item Name="t_ClientSrv Tree Controller States.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Tree Controller States.ctl"/>
         <Item Name="Library Wildcards to Regular.vi" Type="VI" URL="library/string handling/Library Wildcards to Regular.vi"/>
         <Item Name="t_ClientSrv Server File Manipulation Methods.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Server File Manipulation Methods.ctl"/>
         <Item Name="ClientSrv Download.vi" Type="VI" URL="clientsrv/subvis/private/ClientSrv Download.vi"/>
         <Item Name="ClientSrv Upload.vi" Type="VI" URL="clientsrv/subvis/private/ClientSrv Upload.vi"/>
         <Item Name="ClientSrv Server Runlevels_srv.ctl" Type="VI" URL="clientsrv/served/ClientSrv Server Runlevels_srv.ctl"/>
         <Item Name="LuaVIEW Info_srv.ctl" Type="VI" URL="luaview/served/LuaVIEW Info_srv.ctl"/>
         <Item Name="t_ClientSrv Client Main States.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Client Main States.ctl"/>
         <Item Name="t_ClientSrv Server Runlevels Methods.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Server Runlevels Methods.ctl"/>
         <Item Name="ui_ClientSrv Query Machine and Port.vi" Type="VI" URL="clientsrv/subvis/private/dialogs/ui_ClientSrv Query Machine and Port.vi"/>
         <Item Name="t_ClientSrv Query Machine and Port States.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Query Machine and Port States.ctl"/>
         <Item Name="ui_ClientSrv Query Observer Password.vi" Type="VI" URL="clientsrv/subvis/private/dialogs/ui_ClientSrv Query Observer Password.vi"/>
         <Item Name="t_ClientSrv Query Observer Password States.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Query Observer Password States.ctl"/>
         <Item Name="ui_Library Query Listed String.vi" Type="VI" URL="library/gui/ui_Library Query Listed String.vi"/>
         <Item Name="t_Library Query Listed String States.ctl" Type="VI" URL="library/typedefs/t_Library Query Listed String States.ctl"/>
         <Item Name="t_Library Session Methods.ctl" Type="VI" URL="library/typedefs/t_Library Session Methods.ctl"/>
         <Item Name="LuaVIEW Task Console Ancillary.ctl" Type="VI" URL="luaview/typedefs/clusters/LuaVIEW Task Console Ancillary.ctl"/>
         <Item Name="obj_Library Session.vi" Type="VI" URL="library/persistence/obj_Library Session.vi"/>
         <Item Name="ui_Library Query String.vi" Type="VI" URL="library/gui/ui_Library Query String.vi"/>
         <Item Name="t_Library Query String States.ctl" Type="VI" URL="library/typedefs/t_Library Query String States.ctl"/>
         <Item Name="Library Recursively List Files.vi" Type="VI" URL="library/file handling/Library Recursively List Files.vi"/>
         <Item Name="Library Recursively List Directories.vi" Type="VI" URL="library/file handling/Library Recursively List Directories.vi"/>
         <Item Name="LuaVIEW Run or Swap Task_srv.ctl" Type="VI" URL="luaview/served/LuaVIEW Run or Swap Task_srv.ctl"/>
         <Item Name="obj_LuaVIEW Task List_srv.ctl" Type="VI" URL="luaview/served/obj_LuaVIEW Task List_srv.ctl"/>
         <Item Name="LuaVIEW Retrieve Scripts_srv.ctl" Type="VI" URL="luaview/served/LuaVIEW Retrieve Scripts_srv.ctl"/>
         <Item Name="re_LuaVIEW Kill Task_srv.ctl" Type="VI" URL="luaview/served/re_LuaVIEW Kill Task_srv.ctl"/>
         <Item Name="t_LuaVIEW Task Manager Async Actions.ctl" Type="VI" URL="luaview/typedefs/t_LuaVIEW Task Manager Async Actions.ctl"/>
         <Item Name="t_LuaVIEW Task Manager States.ctl" Type="VI" URL="luaview/typedefs/t_LuaVIEW Task Manager States.ctl"/>
         <Item Name="t_LuaVIEW Served Task List Methods.ctl" Type="VI" URL="luaview/typedefs/t_LuaVIEW Served Task List Methods.ctl"/>
         <Item Name="t_LuaVIEW Task Signals.ctl" Type="VI" URL="luaview/typedefs/t_LuaVIEW Task Signals.ctl"/>
         <Item Name="t_LuaVIEW Task Modes.ctl" Type="VI" URL="luaview/typedefs/t_LuaVIEW Task Modes.ctl"/>
         <Item Name="Library MCListBox Resizer.vi" Type="VI" URL="library/gui/Library MCListBox Resizer.vi"/>
         <Item Name="Library Read Text File.vi" Type="VI" URL="library/file handling/Library Read Text File.vi"/>
         <Item Name="Library Extract String Lines.vi" Type="VI" URL="library/string handling/Library Extract String Lines.vi"/>
         <Item Name="re_LuaVIEW Poll Print Buffer_srv.ctl" Type="VI" URL="luaview/served/re_LuaVIEW Poll Print Buffer_srv.ctl"/>
         <Item Name="t_LuaVIEW Task Print Console States.ctl" Type="VI" URL="luaview/typedefs/t_LuaVIEW Task Print Console States.ctl"/>
         <Item Name="LuaVIEW Loaded Function Infos_srv.ctl" Type="VI" URL="luaview/served/LuaVIEW Loaded Function Infos_srv.ctl"/>
         <Item Name="LuaVIEW Get Function Documentation_srv.ctl" Type="VI" URL="luaview/served/LuaVIEW Get Function Documentation_srv.ctl"/>
         <Item Name="LuaVIEW Cleanup Registry_srv.ctl" Type="VI" URL="luaview/served/LuaVIEW Cleanup Registry_srv.ctl"/>
         <Item Name="t_LuaVIEW Function Manager States.ctl" Type="VI" URL="luaview/typedefs/t_LuaVIEW Function Manager States.ctl"/>
         <Item Name="LuaVIEW Function Info.ctl" Type="VI" URL="luaview/typedefs/clusters/LuaVIEW Function Info.ctl"/>
         <Item Name="LuaVIEW Get Function Documentation.vi" Type="VI" URL="luaview/subvis/private/LuaVIEW Get Function Documentation.vi"/>
         <Item Name="LuaVIEW Format HTML Function List.vi" Type="VI" URL="luaview/subvis/private/LuaVIEW Format HTML Function List.vi"/>
         <Item Name="Library Write Text File.vi" Type="VI" URL="library/file handling/Library Write Text File.vi"/>
         <Item Name="LuaVIEW Get Function Info.vi" Type="VI" URL="luaview/subvis/private/LuaVIEW Get Function Info.vi"/>
         <Item Name="LuaVIEW Strip Function Name.vi" Type="VI" URL="luaview/subvis/private/LuaVIEW Strip Function Name.vi"/>
         <Item Name="LuaVIEW Parse Library Infos.vi" Type="VI" URL="luaview/subvis/private/LuaVIEW Parse Library Infos.vi"/>
         <Item Name="Library Line at Offset.vi" Type="VI" URL="library/string handling/Library Line at Offset.vi"/>
         <Item Name="LuaVIEW Check Synopsis_srv.ctl" Type="VI" URL="luaview/served/LuaVIEW Check Synopsis_srv.ctl"/>
         <Item Name="LuaVIEW Parse Function Documentation.vi" Type="VI" URL="luaview/subvis/private/LuaVIEW Parse Function Documentation.vi"/>
         <Item Name="t_LuaVIEW Show Function Documentation States.ctl" Type="VI" URL="luaview/typedefs/t_LuaVIEW Show Function Documentation States.ctl"/>
         <Item Name="t_ClientSrv Remote File Manager States.ctl" Type="VI" URL="clientsrv/typedefs/t_ClientSrv Remote File Manager States.ctl"/>
         <Item Name="DataLog Database Infos_srv.ctl" Type="VI" URL="datalog/served/DataLog Database Infos_srv.ctl"/>
         <Item Name="DataLog Tag and Meta Live_srv.ctl" Type="VI" URL="datalog/served/DataLog Tag and Meta Live_srv.ctl"/>
         <Item Name="t_DataLog Live Tag Chart States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Live Tag Chart States.ctl"/>
         <Item Name="et_DataLog Meta Tag Specifier.ctl" Type="VI" URL="datalog/typedefs/et_DataLog Meta Tag Specifier.ctl"/>
         <Item Name="ui_DataLog Query Tag.vi" Type="VI" URL="datalog/subvis/private/dialogs/ui_DataLog Query Tag.vi"/>
         <Item Name="t_DataLog Tag Info List Methods.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Tag Info List Methods.ctl"/>
         <Item Name="DataLog Tag Subset Last_srv.ctl" Type="VI" URL="datalog/served/DataLog Tag Subset Last_srv.ctl"/>
         <Item Name="t_DataLog Live Tag Table States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Live Tag Table States.ctl"/>
         <Item Name="DataLog Format Point Value.vi" Type="VI" URL="datalog/subvis/private/DataLog Format Point Value.vi"/>
         <Item Name="t_DataLog Tag Config.ctl" Type="VI" URL="datalog/typedefs/clusters/t_DataLog Tag Config.ctl"/>
         <Item Name="t_DataLog Temporal Types.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Temporal Types.ctl"/>
         <Item Name="t_DataLog Value Types.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Value Types.ctl"/>
         <Item Name="t_DataLog Numerical Format.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Numerical Format.ctl"/>
         <Item Name="t_DataLog Logging Algorithms.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Logging Algorithms.ctl"/>
         <Item Name="glb_DataLog MCVD.vi" Type="VI" URL="datalog/subvis/private/glb_DataLog MCVD.vi"/>
         <Item Name="ui_DataLog Get or Query Subset.vi" Type="VI" URL="datalog/subvis/private/dialogs/ui_DataLog Get or Query Subset.vi"/>
         <Item Name="re_DataLog Query_srv.ctl" Type="VI" URL="datalog/served/re_DataLog Query_srv.ctl"/>
         <Item Name="DataLog Log String_srv.ctl" Type="VI" URL="datalog/served/DataLog Log String_srv.ctl"/>
         <Item Name="t_DataLog Log Book States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Log Book States.ctl"/>
         <Item Name="t_DataLog Query Served Methods.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Query Served Methods.ctl"/>
         <Item Name="ui_DataLog Query Large String.vi" Type="VI" URL="datalog/subvis/private/dialogs/ui_DataLog Query Large String.vi"/>
         <Item Name="t_DataLog Query Large String States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Query Large String States.ctl"/>
         <Item Name="ui_DataLog Query Database.vi" Type="VI" URL="datalog/subvis/private/dialogs/ui_DataLog Query Database.vi"/>
         <Item Name="DataLog Databases_srv.ctl" Type="VI" URL="datalog/served/DataLog Databases_srv.ctl"/>
         <Item Name="DataLog Dump Tag Buffer_srv.ctl" Type="VI" URL="datalog/served/DataLog Dump Tag Buffer_srv.ctl"/>
         <Item Name="t_DataLog Log Graph States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Log Graph States.ctl"/>
         <Item Name="t_DataLog Log Table States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Log Table States.ctl"/>
         <Item Name="t_Datalog Table Columns Methods.ctl" Type="VI" URL="datalog/typedefs/t_Datalog Table Columns Methods.ctl"/>
         <Item Name="obj_DataLog Table Columns.vi" Type="VI" URL="datalog/objects/private/obj_DataLog Table Columns.vi"/>
         <Item Name="t_DataLog Table Retrieval Modes.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Table Retrieval Modes.ctl"/>
         <Item Name="ui_DataLog Reorder Listed Strings.vi" Type="VI" URL="datalog/subvis/private/dialogs/ui_DataLog Reorder Listed Strings.vi"/>
         <Item Name="t_DataLog Reorder Listed Strings States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Reorder Listed Strings States.ctl"/>
         <Item Name="ui_DataLog Query Tags.vi" Type="VI" URL="datalog/subvis/private/dialogs/ui_DataLog Query Tags.vi"/>
         <Item Name="ui_DataLog Query Listed Strings.vi" Type="VI" URL="datalog/subvis/private/dialogs/ui_DataLog Query Listed Strings.vi"/>
         <Item Name="t_DataLog Query Listed Strings States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Query Listed Strings States.ctl"/>
         <Item Name="ui_DataLog Show Big String.vi" Type="VI" URL="datalog/subvis/private/dialogs/ui_DataLog Show Big String.vi"/>
         <Item Name="t_DataLog Show Big String States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Show Big String States.ctl"/>
         <Item Name="t_Datalog Time Graph States.ctl" Type="VI" URL="datalog/typedefs/t_Datalog Time Graph States.ctl"/>
         <Item Name="t_Datalog XY Graph States.ctl" Type="VI" URL="datalog/typedefs/t_Datalog XY Graph States.ctl"/>
         <Item Name="t_Datalog Datebase Modes.ctl" Type="VI" URL="datalog/typedefs/t_Datalog Datebase Modes.ctl"/>
         <Item Name="DataLog Set Tag Value_srv.ctl" Type="VI" URL="datalog/served/DataLog Set Tag Value_srv.ctl"/>
         <Item Name="t_DataLog Tag Manager States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Tag Manager States.ctl"/>
         <Item Name="ui_DataLog Query Tag Creation Parameters.vi" Type="VI" URL="datalog/subvis/private/dialogs/ui_DataLog Query Tag Creation Parameters.vi"/>
         <Item Name="t_DataLog Query Tag Creation Parameters States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Query Tag Creation Parameters States.ctl"/>
         <Item Name="ui_DataLog Query Meta.vi" Type="VI" URL="datalog/subvis/private/dialogs/ui_DataLog Query Meta.vi"/>
         <Item Name="t_DataLog Query Meta States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Query Meta States.ctl"/>
         <Item Name="DataLog Append Meta Specifier.vi" Type="VI" URL="datalog/subvis/private/DataLog Append Meta Specifier.vi"/>
         <Item Name="ui_DataLog Query Tag Configuration.vi" Type="VI" URL="datalog/subvis/private/dialogs/ui_DataLog Query Tag Configuration.vi"/>
         <Item Name="t_DataLog Query Tag Configuration States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Query Tag Configuration States.ctl"/>
         <Item Name="ui_DataLog Query New Value.vi" Type="VI" URL="datalog/subvis/private/dialogs/ui_DataLog Query New Value.vi"/>
         <Item Name="t_DataLog Query New Value States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Query New Value States.ctl"/>
         <Item Name="DataLog Format Stats.vi" Type="VI" URL="datalog/subvis/private/DataLog Format Stats.vi"/>
         <Item Name="t_DataLog Point.ctl" Type="VI" URL="datalog/typedefs/clusters/t_DataLog Point.ctl"/>
         <Item Name="t_DataLog Tag Subset Editor States.ctl" Type="VI" URL="datalog/typedefs/t_DataLog Tag Subset Editor States.ctl"/>
      </Item>
      <Item Name="Build Specifications" Type="Build">
         <Item Name="Client" Type="EXE">
            <Property Name="App_applicationGUID" Type="Str">{A7AF0DD9-225A-453F-999F-2455665D8512}</Property>
            <Property Name="App_applicationName" Type="Str">Client.exe</Property>
            <Property Name="App_companyName" Type="Str">CIT Engineering</Property>
            <Property Name="App_fileDescription" Type="Str">Client.exe</Property>
            <Property Name="App_fileType" Type="Int">1</Property>
            <Property Name="App_fileVersion.major" Type="Int">1</Property>
            <Property Name="App_INI_aliasGUID" Type="Str">{5461A7C1-D0E9-47C8-BC6E-9332DFC03C2E}</Property>
            <Property Name="App_INI_GUID" Type="Str">{CE87CC68-23A7-49A1-BC33-08772BA717AE}</Property>
            <Property Name="App_internalName" Type="Str">Client.exe</Property>
            <Property Name="App_legalCopyright" Type="Str">Copyright 2008 CIT Engineering</Property>
            <Property Name="App_productName" Type="Str">Client.exe</Property>
            <Property Name="Bld_buildSpecName" Type="Str">Client</Property>
            <Property Name="Destination[0].destName" Type="Str">Client.exe</Property>
            <Property Name="Destination[0].path" Type="Path">../builds/NI_AB_PROJECTNAME/Client/internal.llb</Property>
            <Property Name="Destination[0].type" Type="Str">App</Property>
            <Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
            <Property Name="Destination[1].path" Type="Path">../builds/NI_AB_PROJECTNAME/Client</Property>
            <Property Name="DestinationCount" Type="Int">2</Property>
            <Property Name="Source[0].itemID" Type="Str">{2E25D77B-50F1-4F42-B7A0-311A44E820AA}</Property>
            <Property Name="Source[0].type" Type="Str">Container</Property>
            <Property Name="Source[1].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[1].itemID" Type="Ref">/My Computer/ClientSrv Client.vi</Property>
            <Property Name="Source[1].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[1].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[1].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[1].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[1].properties[2].type" Type="Str">Run when opened</Property>
            <Property Name="Source[1].properties[2].value" Type="Bool">true</Property>
            <Property Name="Source[1].properties[3].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[1].properties[3].value" Type="Bool">false</Property>
            <Property Name="Source[1].propertiesCount" Type="Int">4</Property>
            <Property Name="Source[1].sourceInclusion" Type="Str">TopLevel</Property>
            <Property Name="Source[1].type" Type="Str">VI</Property>
            <Property Name="Source[10].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[10].itemID" Type="Ref">/My Computer/Dynamic VIs/tui_DataLog Log Graph.vit</Property>
            <Property Name="Source[10].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[10].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[10].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[10].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[10].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[10].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[10].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[10].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[10].type" Type="Str">VI</Property>
            <Property Name="Source[11].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[11].itemID" Type="Ref">/My Computer/Dynamic VIs/tui_DataLog Log Table.vi</Property>
            <Property Name="Source[11].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[11].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[11].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[11].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[11].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[11].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[11].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[11].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[11].type" Type="Str">VI</Property>
            <Property Name="Source[12].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[12].itemID" Type="Ref">/My Computer/Dynamic VIs/ui_Datalog Time Graph.vit</Property>
            <Property Name="Source[12].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[12].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[12].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[12].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[12].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[12].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[12].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[12].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[12].type" Type="Str">VI</Property>
            <Property Name="Source[13].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[13].itemID" Type="Ref">/My Computer/Dynamic VIs/ui_Datalog XY Graph.vit</Property>
            <Property Name="Source[13].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[13].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[13].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[13].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[13].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[13].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[13].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[13].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[13].type" Type="Str">VI</Property>
            <Property Name="Source[14].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[14].itemID" Type="Ref">/My Computer/Dynamic VIs/tui_DataLog Tag Manager.vi</Property>
            <Property Name="Source[14].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[14].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[14].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[14].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[14].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[14].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[14].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[14].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[14].type" Type="Str">VI</Property>
            <Property Name="Source[15].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[15].itemID" Type="Ref">/My Computer/Dynamic VIs/tui_Datalog Tag Subset Editor.vi</Property>
            <Property Name="Source[15].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[15].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[15].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[15].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[15].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[15].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[15].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[15].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[15].type" Type="Str">VI</Property>
            <Property Name="Source[16].destinationIndex" Type="Int">1</Property>
            <Property Name="Source[16].itemID" Type="Ref">/My Computer/Support Files/Client.ini</Property>
            <Property Name="Source[16].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[16].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[16].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[16].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[16].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[16].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[16].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[16].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[2].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[2].itemID" Type="Ref">/My Computer/Dynamic VIs/tui_LuaVIEW Task Manager.vi</Property>
            <Property Name="Source[2].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[2].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[2].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[2].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[2].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[2].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[2].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[2].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[2].type" Type="Str">VI</Property>
            <Property Name="Source[3].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[3].itemID" Type="Ref">/My Computer/Dynamic VIs/ui_LuaVIEW Task Console.vit</Property>
            <Property Name="Source[3].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[3].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[3].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[3].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[3].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[3].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[3].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[3].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[3].type" Type="Str">VI</Property>
            <Property Name="Source[4].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[4].itemID" Type="Ref">/My Computer/Dynamic VIs/tui_LuaVIEW Function Manager.vi</Property>
            <Property Name="Source[4].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[4].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[4].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[4].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[4].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[4].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[4].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[4].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[4].type" Type="Str">VI</Property>
            <Property Name="Source[5].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[5].itemID" Type="Ref">/My Computer/Dynamic VIs/ui_LuaVIEW Show Function Documentation.vit</Property>
            <Property Name="Source[5].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[5].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[5].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[5].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[5].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[5].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[5].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[5].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[5].type" Type="Str">VI</Property>
            <Property Name="Source[6].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[6].itemID" Type="Ref">/My Computer/Dynamic VIs/tui_ClientSrv Remote File Manager.vi</Property>
            <Property Name="Source[6].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[6].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[6].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[6].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[6].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[6].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[6].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[6].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[6].type" Type="Str">VI</Property>
            <Property Name="Source[7].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[7].itemID" Type="Ref">/My Computer/Dynamic VIs/tui_DataLog Live Tag Chart.vit</Property>
            <Property Name="Source[7].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[7].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[7].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[7].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[7].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[7].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[7].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[7].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[7].type" Type="Str">VI</Property>
            <Property Name="Source[8].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[8].itemID" Type="Ref">/My Computer/Dynamic VIs/tui_DataLog Live Tag Table.vit</Property>
            <Property Name="Source[8].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[8].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[8].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[8].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[8].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[8].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[8].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[8].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[8].type" Type="Str">VI</Property>
            <Property Name="Source[9].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[9].itemID" Type="Ref">/My Computer/Dynamic VIs/tui_DataLog Log Book.vit</Property>
            <Property Name="Source[9].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[9].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[9].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[9].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[9].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[9].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[9].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[9].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[9].type" Type="Str">VI</Property>
            <Property Name="SourceCount" Type="Int">17</Property>
         </Item>
         <Item Name="Client Installer" Type="Installer">
            <Property Name="arpCompany" Type="Str">CIT Engineering</Property>
            <Property Name="arpURL" Type="Str">http://www.CITEngineering.com/</Property>
            <Property Name="AutoIncrement" Type="Bool">true</Property>
            <Property Name="BuildLabel" Type="Str">Client Installer</Property>
            <Property Name="BuildLocation" Type="Path">../../Builds/Client/Client Installer</Property>
            <Property Name="DirInfo.Count" Type="Int">1</Property>
            <Property Name="DirInfo.DefaultDir" Type="Str">{60EB7B7C-7523-4C21-90A7-6851AEAB8072}</Property>
            <Property Name="DirInfo[0].DirName" Type="Str">Client</Property>
            <Property Name="DirInfo[0].DirTag" Type="Str">{60EB7B7C-7523-4C21-90A7-6851AEAB8072}</Property>
            <Property Name="DirInfo[0].ParentTag" Type="Str">{3912416A-D2E5-411B-AFEE-B63654D690C0}</Property>
            <Property Name="DistID" Type="Str">{4E3CBEBB-F4C8-46E8-BAB5-DB3E724EBED7}</Property>
            <Property Name="DistParts.Count" Type="Int">1</Property>
            <Property Name="DistPartsInfo[0].FlavorID" Type="Str">DefaultFull</Property>
            <Property Name="DistPartsInfo[0].ProductID" Type="Str">{065F29A4-D4D9-4BB9-85AF-8A878907BBD6}</Property>
            <Property Name="DistPartsInfo[0].ProductName" Type="Str">NI LabVIEW Run-Time Engine 8.5.1</Property>
            <Property Name="DistPartsInfo[0].UpgradeCode" Type="Str">{99D796C3-2E53-4839-A25B-22C26B029103}</Property>
            <Property Name="FileInfo.Count" Type="Int">3</Property>
            <Property Name="FileInfo[0].DirTag" Type="Str">{60EB7B7C-7523-4C21-90A7-6851AEAB8072}</Property>
            <Property Name="FileInfo[0].FileName" Type="Str">Client.exe</Property>
            <Property Name="FileInfo[0].FileTag" Type="Str">{A7AF0DD9-225A-453F-999F-2455665D8512}</Property>
            <Property Name="FileInfo[0].Type" Type="Int">3</Property>
            <Property Name="FileInfo[0].TypeID" Type="Ref">/My Computer/Build Specifications/Client</Property>
            <Property Name="FileInfo[1].DirTag" Type="Str">{60EB7B7C-7523-4C21-90A7-6851AEAB8072}</Property>
            <Property Name="FileInfo[1].FileName" Type="Str">Client.aliases</Property>
            <Property Name="FileInfo[1].FileTag" Type="Str">{5461A7C1-D0E9-47C8-BC6E-9332DFC03C2E}</Property>
            <Property Name="FileInfo[1].Type" Type="Int">3</Property>
            <Property Name="FileInfo[1].TypeID" Type="Ref">/My Computer/Build Specifications/Client</Property>
            <Property Name="FileInfo[2].DirTag" Type="Str">{60EB7B7C-7523-4C21-90A7-6851AEAB8072}</Property>
            <Property Name="FileInfo[2].FileName" Type="Str">Client.ini</Property>
            <Property Name="FileInfo[2].FileTag" Type="Str">{CE87CC68-23A7-49A1-BC33-08772BA717AE}</Property>
            <Property Name="FileInfo[2].Type" Type="Int">3</Property>
            <Property Name="FileInfo[2].TypeID" Type="Ref">/My Computer/Build Specifications/Client</Property>
            <Property Name="InstSpecVersion" Type="Str">8508002</Property>
            <Property Name="LicenseFile" Type="Ref"></Property>
            <Property Name="OSCheck" Type="Int">0</Property>
            <Property Name="OSCheck_Vista" Type="Bool">false</Property>
            <Property Name="ProductName" Type="Str">Client</Property>
            <Property Name="ProductVersion" Type="Str">1.0.6</Property>
            <Property Name="ReadmeFile" Type="Ref"></Property>
            <Property Name="ShortcutInfo.Count" Type="Int">1</Property>
            <Property Name="ShortcutInfo[0].DirTag" Type="Str">{B9E310F1-839C-48B7-8CAE-33000780C26E}</Property>
            <Property Name="ShortcutInfo[0].FileTag" Type="Str">{A7AF0DD9-225A-453F-999F-2455665D8512}</Property>
            <Property Name="ShortcutInfo[0].FileTagDir" Type="Str">{60EB7B7C-7523-4C21-90A7-6851AEAB8072}</Property>
            <Property Name="ShortcutInfo[0].Name" Type="Str">Client</Property>
            <Property Name="ShortcutInfo[0].SubDir" Type="Str">Client</Property>
            <Property Name="UpgradeCode" Type="Str">{F01EB1E3-D4A4-40A2-B4BF-1DED43F54D07}</Property>
         </Item>
      </Item>
   </Item>
</Project>
