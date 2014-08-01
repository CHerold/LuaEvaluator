<?xml version='1.0'?>
<Project Type="Project" LVVersion="8508002">
   <Item Name="My Computer" Type="My Computer">
      <Property Name="CCSymbols" Type="Str"></Property>
      <Property Name="mathScriptPath" Type="Str">C:\Documents and Settings\Albert-Jan Brouwer\My Documents\LabVIEW Data</Property>
      <Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
      <Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
      <Property Name="server.tcp.acl" Type="Str">290000000A000000010000001D00000003000000010000002A10000000030000000000010000000000</Property>
      <Property Name="server.tcp.enabled" Type="Bool">true</Property>
      <Property Name="server.tcp.port" Type="Int">3363</Property>
      <Property Name="server.tcp.serviceName" Type="Str"></Property>
      <Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
      <Property Name="server.vi.access" Type="Str">+*_srv.vi</Property>
      <Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
      <Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
      <Property Name="specify.custom.address" Type="Bool">false</Property>
      <Item Name="Support Files" Type="Folder">
         <Item Name="Server.ini" Type="Document" URL="datalog/build/server files/Server.ini"/>
         <Item Name="readme.txt" Type="Document" URL="datalog/build/server files/readme.txt"/>
      </Item>
      <Item Name="DataLog Server Boot.vi" Type="VI" URL="datalog/build/DataLog Server Boot.vi"/>
      <Item Name="Dependencies" Type="Dependencies"/>
      <Item Name="Build Specifications" Type="Build">
         <Item Name="Server" Type="EXE">
            <Property Name="App_applicationGUID" Type="Str">{D7149485-7262-46DE-9DB4-7F9B356BDB0E}</Property>
            <Property Name="App_applicationName" Type="Str">Server.exe</Property>
            <Property Name="App_companyName" Type="Str">CIT Engineering</Property>
            <Property Name="App_fileDescription" Type="Str">Server.exe</Property>
            <Property Name="App_fileType" Type="Int">1</Property>
            <Property Name="App_fileVersion.major" Type="Int">1</Property>
            <Property Name="App_INI_aliasGUID" Type="Str">{3D452E89-C105-45D0-BAC9-9FE4B66C859A}</Property>
            <Property Name="App_INI_GUID" Type="Str">{F911EE36-FD72-43D9-9340-B5B1AAC53C5B}</Property>
            <Property Name="App_internalName" Type="Str">Server.exe</Property>
            <Property Name="App_legalCopyright" Type="Str">Copyright 2008 CIT Engineering</Property>
            <Property Name="App_productName" Type="Str">Server.exe</Property>
            <Property Name="Bld_buildSpecName" Type="Str">Server</Property>
            <Property Name="Destination[0].destName" Type="Str">Server.exe</Property>
            <Property Name="Destination[0].path" Type="Path">../builds/NI_AB_PROJECTNAME/Server/internal.llb</Property>
            <Property Name="Destination[0].type" Type="Str">App</Property>
            <Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
            <Property Name="Destination[1].path" Type="Path">../builds/NI_AB_PROJECTNAME/Server</Property>
            <Property Name="DestinationCount" Type="Int">2</Property>
            <Property Name="Source[0].itemID" Type="Str">{B5A1F0CB-9EAA-4EEE-BA81-EAA1F35A6B6D}</Property>
            <Property Name="Source[0].type" Type="Str">Container</Property>
            <Property Name="Source[1].destinationIndex" Type="Int">0</Property>
            <Property Name="Source[1].itemID" Type="Ref">/My Computer/DataLog Server Boot.vi</Property>
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
            <Property Name="Source[2].destinationIndex" Type="Int">1</Property>
            <Property Name="Source[2].itemID" Type="Ref">/My Computer/Support Files/Server.ini</Property>
            <Property Name="Source[2].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[2].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[2].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[2].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[2].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[2].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[2].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[2].sourceInclusion" Type="Str">Include</Property>
            <Property Name="Source[3].destinationIndex" Type="Int">1</Property>
            <Property Name="Source[3].itemID" Type="Ref">/My Computer/Support Files/readme.txt</Property>
            <Property Name="Source[3].properties[0].type" Type="Str">Allow debugging</Property>
            <Property Name="Source[3].properties[0].value" Type="Bool">false</Property>
            <Property Name="Source[3].properties[1].type" Type="Str">Remove block diagram</Property>
            <Property Name="Source[3].properties[1].value" Type="Bool">true</Property>
            <Property Name="Source[3].properties[2].type" Type="Str">Show Abort button</Property>
            <Property Name="Source[3].properties[2].value" Type="Bool">false</Property>
            <Property Name="Source[3].propertiesCount" Type="Int">3</Property>
            <Property Name="Source[3].sourceInclusion" Type="Str">Include</Property>
            <Property Name="SourceCount" Type="Int">4</Property>
         </Item>
         <Item Name="Server Installer" Type="Installer">
            <Property Name="arpCompany" Type="Str">CIT Engineering</Property>
            <Property Name="arpURL" Type="Str">http://www.CITEngineering.com/</Property>
            <Property Name="AutoIncrement" Type="Bool">true</Property>
            <Property Name="BuildLabel" Type="Str">Server Installer</Property>
            <Property Name="BuildLocation" Type="Path">../../Builds/Server/Server Installer</Property>
            <Property Name="DirInfo.Count" Type="Int">1</Property>
            <Property Name="DirInfo.DefaultDir" Type="Str">{06DA8DCE-C7AE-4F5E-BFC3-73A60C29CBF7}</Property>
            <Property Name="DirInfo[0].DirName" Type="Str">Server</Property>
            <Property Name="DirInfo[0].DirTag" Type="Str">{06DA8DCE-C7AE-4F5E-BFC3-73A60C29CBF7}</Property>
            <Property Name="DirInfo[0].ParentTag" Type="Str">{3912416A-D2E5-411B-AFEE-B63654D690C0}</Property>
            <Property Name="DistID" Type="Str">{EB909DF5-2C81-48F6-BA64-187B7CB2CDF9}</Property>
            <Property Name="DistParts.Count" Type="Int">1</Property>
            <Property Name="DistPartsInfo[0].FlavorID" Type="Str">DefaultFull</Property>
            <Property Name="DistPartsInfo[0].ProductID" Type="Str">{065F29A4-D4D9-4BB9-85AF-8A878907BBD6}</Property>
            <Property Name="DistPartsInfo[0].ProductName" Type="Str">NI LabVIEW Run-Time Engine 8.5.1</Property>
            <Property Name="DistPartsInfo[0].UpgradeCode" Type="Str">{99D796C3-2E53-4839-A25B-22C26B029103}</Property>
            <Property Name="FileInfo.Count" Type="Int">4</Property>
            <Property Name="FileInfo[0].DirTag" Type="Str">{06DA8DCE-C7AE-4F5E-BFC3-73A60C29CBF7}</Property>
            <Property Name="FileInfo[0].FileName" Type="Str">Server.exe</Property>
            <Property Name="FileInfo[0].FileTag" Type="Str">{D7149485-7262-46DE-9DB4-7F9B356BDB0E}</Property>
            <Property Name="FileInfo[0].Type" Type="Int">3</Property>
            <Property Name="FileInfo[0].TypeID" Type="Ref">/My Computer/Build Specifications/Server</Property>
            <Property Name="FileInfo[1].DirTag" Type="Str">{06DA8DCE-C7AE-4F5E-BFC3-73A60C29CBF7}</Property>
            <Property Name="FileInfo[1].FileName" Type="Str">Server.aliases</Property>
            <Property Name="FileInfo[1].FileTag" Type="Str">{3D452E89-C105-45D0-BAC9-9FE4B66C859A}</Property>
            <Property Name="FileInfo[1].Type" Type="Int">3</Property>
            <Property Name="FileInfo[1].TypeID" Type="Ref">/My Computer/Build Specifications/Server</Property>
            <Property Name="FileInfo[2].DirTag" Type="Str">{06DA8DCE-C7AE-4F5E-BFC3-73A60C29CBF7}</Property>
            <Property Name="FileInfo[2].FileName" Type="Str">Server.ini</Property>
            <Property Name="FileInfo[2].FileTag" Type="Str">{F911EE36-FD72-43D9-9340-B5B1AAC53C5B}</Property>
            <Property Name="FileInfo[2].Type" Type="Int">3</Property>
            <Property Name="FileInfo[2].TypeID" Type="Ref">/My Computer/Build Specifications/Server</Property>
            <Property Name="FileInfo[3].DirTag" Type="Str">{06DA8DCE-C7AE-4F5E-BFC3-73A60C29CBF7}</Property>
            <Property Name="FileInfo[3].FileName" Type="Str">readme.txt</Property>
            <Property Name="FileInfo[3].FileTag" Type="Ref">/My Computer/Support Files/readme.txt</Property>
            <Property Name="FileInfo[3].Type" Type="Int">3</Property>
            <Property Name="FileInfo[3].TypeID" Type="Ref">/My Computer/Build Specifications/Server</Property>
            <Property Name="InstSpecVersion" Type="Str">8508002</Property>
            <Property Name="LicenseFile" Type="Ref"></Property>
            <Property Name="OSCheck" Type="Int">0</Property>
            <Property Name="OSCheck_Vista" Type="Bool">false</Property>
            <Property Name="ProductName" Type="Str">Server</Property>
            <Property Name="ProductVersion" Type="Str">1.0.5</Property>
            <Property Name="ReadmeFile" Type="Ref"></Property>
            <Property Name="ShortcutInfo.Count" Type="Int">2</Property>
            <Property Name="ShortcutInfo[0].DirTag" Type="Str">{B9E310F1-839C-48B7-8CAE-33000780C26E}</Property>
            <Property Name="ShortcutInfo[0].FileTag" Type="Str">{D7149485-7262-46DE-9DB4-7F9B356BDB0E}</Property>
            <Property Name="ShortcutInfo[0].FileTagDir" Type="Str">{06DA8DCE-C7AE-4F5E-BFC3-73A60C29CBF7}</Property>
            <Property Name="ShortcutInfo[0].Name" Type="Str">Server</Property>
            <Property Name="ShortcutInfo[0].SubDir" Type="Str">Server</Property>
            <Property Name="ShortcutInfo[1].DirTag" Type="Str">{B9E310F1-839C-48B7-8CAE-33000780C26E}</Property>
            <Property Name="ShortcutInfo[1].FileTag" Type="Ref">/My Computer/Support Files/readme.txt</Property>
            <Property Name="ShortcutInfo[1].FileTagDir" Type="Str">{06DA8DCE-C7AE-4F5E-BFC3-73A60C29CBF7}</Property>
            <Property Name="ShortcutInfo[1].Name" Type="Str">readme</Property>
            <Property Name="ShortcutInfo[1].SubDir" Type="Str">Server</Property>
            <Property Name="UpgradeCode" Type="Str">{C72FBCE0-4555-4F40-B068-EEBEE78CA208}</Property>
         </Item>
      </Item>
   </Item>
</Project>
