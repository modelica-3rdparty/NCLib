package Network

  annotation(preferedView="info",Documentation(info="<html>
<h4>Author</h4>
<p>
  Liu Liu<br>
  TU Kaiserslautern<br>
  FB EIT, JPA²<br>
  Erwin-Schrödinger-Str. 12<br>
  67663 Kaiserslautern<br>
  Germany<br>
  eMail: <a href=\"mailto:liuliu@eit.uni-kl.de\">liuliu@eit.uni-kl.de</a><br>
  WWW: <a href=\"http://www.eit.uni-kl.de/frey\">http://www.eit.uni-kl.de/frey</a>
</p>
<h4>Copyright holder</h4>
<p>
  TU Kaiserslautern<br>
  FB EIT, JPA²<br>
  Erwin-Schrödinger-Str. 12<br>
  67663 Kaiserslautern<br>
  Germany<br>
</p>
<h4>Copyright (C) 2008</h4>
<p>
<i>The Controller package is <b>free</b> software;
it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica Standard Library 2.2.2.</i>
</p>
</html>"));
 annotation (Documentation(info="<html>The network library currently supports three transmission protocols: <a href= Modelica://Network.Ethernet >Switched Ethernet </a>, <a href=Modelica:// Network.WLAN>WLAN</a> und <a href=Modelica://Network.ZigBee>ZigBee</a>.
The Network library simulate the physical layer and the medium-access layer of above mentioned networks. High layer protocols such as TCP/IP are not simulated.


</html>"),uses(Modelica(version="2.2.2")));

  package Examples "Application templates of three supported networks. "
    model EthernetExample "Application template of Switched Ethernet."
      annotation (Diagram, Icon);
      Network.Ethernet.EthernetPrimaryController transceiver_Task(
                                                 destinationAddress=4,
          transmittPeriod=0.1)
        annotation (extent=[-108,-20; -88,0]);
      replaceable Ethernet.Switch4Ports switch_BASIC(cacheSize=64, SAT=[1,1; 2,
            2; 3,3; 4,3])                            extends
        Network.Ethernet.SwitchBASIC
                              annotation (extent=[-34,-60; -6,-32]);
      Network.Ethernet.EthernetPrimaryController transceiver_Task1(     i(start=
             2),
        destinationAddress=3,
        transmittPeriod=0.1)
                 annotation (extent=[-120,22; -100,42],
                                                    rotation=0);
      Network.Ethernet.EthernetPrimaryController transceiver_Task2(     i(start=
             3),
        destinationAddress=1,
        transmittPeriod=0.1)
                 annotation (extent=[88,30; 108,50], rotation=180);
      Network.Ethernet.EthernetPrimaryController transceiver_Task3(     i(start=
             4),
        destinationAddress=2,
        transmittPeriod=0.1)
                 annotation (extent=[76,-12; 96,8], rotation=180);
      Ethernet.Cable cable annotation (extent=[-62,-18; -26,10],rotation=180);
      Ethernet.Cable cable1 annotation (extent=[-58,20; -38,46], rotation=0);
      Ethernet.Cable cable2 annotation (extent=[26,14; 64,50], rotation=0);
      Ethernet.Cable cable3 annotation (extent=[18,-28; 56,2],   rotation=90);
      replaceable Ethernet.Switch4Ports switch_BASIC1(
                                                     cacheSize=64, SAT=[1,1; 2,
            1; 3,2; 4,3])                            extends
        Network.Ethernet.SwitchBASIC
                              annotation (extent=[20,-60; 48,-32]);
      Ethernet.Cable cable4 annotation (extent=[-8,-8; 16,16],   rotation=0);
      replaceable Network.Ethernet.EthernetTransceiverModul transceivermodul(
                                                                      sourceAddress=2)
        extends Network.CommonComponents.PartialTransceivermodul
        annotation (extent=[-82,28; -62,48]);
      replaceable Network.Ethernet.EthernetTransceiverModul transceivermodul1(
          sourceAddress=1) extends
        Network.CommonComponents.PartialTransceivermodul
        annotation (extent=[-82,-14; -66,2]);
      replaceable Network.Ethernet.EthernetTransceiverModul transceivermodul2(
          sourceAddress=3) extends
        Network.CommonComponents.PartialTransceivermodul
        annotation (extent=[76,48; 60,64]);
      replaceable Network.Ethernet.EthernetTransceiverModul transceivermodul3(
         sourceAddress=3) extends
        Network.CommonComponents.PartialTransceivermodul
        annotation (extent=[70,-10; 54,6]);
    equation
      connect(transceivermodul.networkPort, cable1.ethernetPort_L)
        annotation (points=[-66.8,46.3; -61.4,46.3; -61.4,32.09; -56,32.09],
          style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(transceivermodul1.networkPort, cable.ethernetPort_R)
        annotation (points=[-69.84,0.64; -61.4,0.64; -61.4,-3.02; -57.32,-3.02],
          style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4,
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(transceivermodul2.networkPort, cable2.ethernetPort_R)
        annotation (points=[63.84,62.64; 63.84,47.32; 59.06,47.32; 59.06,30.74],
          style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4,
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(transceivermodul3.networkPort, cable3.ethernetPort_R)
        annotation (points=[57.84,4.64; 48.92,4.64; 48.92,-1.9; 38.33,-1.9],
          style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4,
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(transceiver_Task1.iCConnector, transceivermodul.iCConnector)
        annotation (points=[-102.6,33.4; -90.3,33.4; -90.3,30.3; -76.8,30.3],
          style(color=2, rgbcolor={0,255,0}));
      connect(transceiver_Task.iCConnector, transceivermodul1.iCConnector)
        annotation (points=[-90.6,-8.6; -85.3,-8.6; -85.3,-12.16; -77.84,-12.16],
          style(color=2, rgbcolor={0,255,0}));
      connect(transceivermodul2.iCConnector, transceiver_Task2.iCConnector)
        annotation (points=[71.84,49.84; 80.92,49.84; 80.92,38.6; 90.6,38.6],
          style(color=2, rgbcolor={0,255,0}));
      connect(transceivermodul3.iCConnector, transceiver_Task3.iCConnector)
        annotation (points=[65.84,-8.16; 72.92,-8.16; 72.92,-3.4; 78.6,-3.4],
          style(color=2, rgbcolor={0,255,0}));
      connect(cable.ethernetPort_L, switch_BASIC.ethernetPort_1) annotation (points=[-29.6,
            -3.02; -29.6,-19.51; -32.88,-19.51; -32.88,-34.24],       style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(cable1.ethernetPort_R, switch_BASIC.ethernetPort_2) annotation (
          points=[-40.6,32.09; -40,32; -26.44,32; -26.44,-34.1], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(cable4.ethernetPort_L, switch_BASIC.ethernetPort_3) annotation (
          points=[-5.6,3.16; -5.6,-15.42; -15.8,-15.42; -15.8,-33.96], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(cable4.ethernetPort_R, switch_BASIC1.ethernetPort_1) annotation (
          points=[12.88,3.16; 12.88,-15.42; 21.12,-15.42; 21.12,-34.24], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(switch_BASIC1.ethernetPort_2, cable2.ethernetPort_L) annotation (
          points=[27.56,-34.1; 27.56,-1.05; 29.8,-1.05; 29.8,30.74], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(cable3.ethernetPort_L, switch_BASIC1.ethernetPort_3) annotation (
          points=[38.33,-25; 38.33,-29.5; 38.2,-29.5; 38.2,-33.96], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
    end EthernetExample;

    model WLANExample "Application template of WLAN."
      annotation (Diagram);
      replaceable Network.WLAN.WLANSharedmedium cSMA_CA(
        transmissionRate=11000,
        intermediaSystemAddress=3,
        intermedia=false)            extends
        Network.CommonComponents.CSMACAmedium
        annotation (extent=[-32,-48; 48,16]);
      Network.WLAN.WLANPrimaryController transceiver_Task1(
        transmittPeriod=0.01,
        receivePeriod=0.001,
        receiveBegin=0.001,
        i(start=5),
        transmittBegin=0.001,
        destinationAddress=1)
                            annotation (extent=[-88,-76; -68,-56]);
      Network.WLAN.WLANPrimaryController transceiver_Task3(
        transmittPeriod=0.01,
        receiveBegin=0.001,
        transmittBegin=0.001,
        receivePeriod=0.001,
        destinationAddress=2)
                             annotation (extent=[-98,24; -78,44]);
      replaceable Network.WLAN.WLANTransceivermodul transceivermodul(
                                                         sourceAddress=1)
        extends Network.CommonComponents.PartialTransceivermodul
        annotation (extent=[-60,30; -40,50]);
      replaceable Network.WLAN.WLANTransceivermodul transceivermodul1(
                                                          sourceAddress=2)
        extends Network.CommonComponents.PartialTransceivermodul
        annotation (extent=[-58,-66; -38,-46]);
    equation
      connect(transceivermodul.networkPort, cSMA_CA.networkPort[1])
        annotation (points=[-44.8,48.3; -44.8,15.15; 7.6,15.15; 7.6,-15.68],
          style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(transceivermodul1.networkPort, cSMA_CA.networkPort[2])
        annotation (points=[-42.8,-47.7; -18.4,-47.7; -18.4,-15.68; 7.6,-15.68],
          style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1));
      connect(transceiver_Task3.iCConnector, transceivermodul.iCConnector)
        annotation (points=[-80.6,35.4; -68.3,35.4; -68.3,32.3; -54.8,32.3],
          style(color=2, rgbcolor={0,255,0}));
      connect(transceivermodul1.iCConnector, transceiver_Task1.iCConnector)
        annotation (points=[-52.8,-63.7; -62.4,-63.7; -62.4,-64.6; -70.6,-64.6],
          style(color=2, rgbcolor={0,255,0}));
    end WLANExample;

    model ZigBeeExample "Application template of ZigBee."

      annotation (Diagram(
          Text(
            extent=[-98,46; -64,34],
            style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              fillColor=68,
              rgbfillColor={170,213,255}),
            string="Controller A"),
          Text(
            extent=[-92,52; -68,42],
            style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              fillColor=68,
              rgbfillColor={170,213,255}),
            string="Primary"),
          Text(
            extent=[-96,-68; -62,-80],
            style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              fillColor=68,
              rgbfillColor={170,213,255}),
            string="Controller B"),
          Text(
            extent=[-90,-62; -66,-72],
            style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              fillColor=68,
              rgbfillColor={170,213,255}),
            string="Primary"),
          Text(
            extent=[-20,-122; 14,-134],
            style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              fillColor=68,
              rgbfillColor={170,213,255}),
            string="Controller B")));

      Network.ZigBee.ZigBeePrimaryController transceiver_Task(
        i(start=2),
        receivePeriod=0.01,
        destinationAddress=2,
        transmittPeriod=0.05)
        annotation (extent=[-100,-12; -48,48]);
      Network.ZigBee.ZigBeePrimaryController transceiver_Task1(
        receivePeriod=0.01,
        destinationAddress=1,
        transmittPeriod=0.05) annotation (extent=[-100,-70; -46,-10]);
      replaceable Network.ZigBee.ZigbeeTransceivermodul cSMA_CA_tranceivermodul(
                                                                         sourceAddress=1, maxBE=5)
        extends Network.CommonComponents.CSMACAtransceivermodul
        annotation (extent=[-48,-2; -14,32]);
      replaceable Network.ZigBee.ZigbeeTransceivermodul
        cSMA_CA_tranceivermodul1(
          sourceAddress=2)
        extends Network.CommonComponents.CSMACAtransceivermodul
        annotation (extent=[-48,-58; -14,-24]);
      replaceable Network.ZigBee.ZigBeeSharedMedium cSMA_CA_Medium(
          intermediaSystemAddress=3, intermedia=false)
                                     extends
        Network.CommonComponents.CSMACAmedium
        annotation (extent=[28,-8; 48,12]);
    equation
      connect(cSMA_CA_tranceivermodul.networkPort, cSMA_CA_Medium.networkPort[1])
        annotation (points=[-22.16,29.11; 7.92,29.11; 7.92,2.1; 37.9,2.1], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(cSMA_CA_tranceivermodul1.networkPort, cSMA_CA_Medium.networkPort[2])
        annotation (points=[-22.16,-26.89; 7.92,-26.89; 7.92,2.1; 37.9,2.1], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(transceiver_Task.iCConnector, cSMA_CA_tranceivermodul.iCConnector)
        annotation (points=[-54.76,22.2; -54.76,12.1; -39.16,12.1; -39.16,1.91],
          style(
          color=2,
          rgbcolor={0,255,0},
          fillColor=74,
          rgbfillColor={0,0,127},
          fillPattern=1));
      connect(transceiver_Task1.iCConnector, cSMA_CA_tranceivermodul1.iCConnector)
        annotation (points=[-53.02,-35.8; -53.02,-44.9; -39.16,-44.9; -39.16,
            -54.09], style(
          color=2,
          rgbcolor={0,255,0},
          fillColor=74,
          rgbfillColor={0,0,127},
          fillPattern=1));
    end ZigBeeExample;

     model CANExample

      annotation (Diagram, DymolaStoredErrors);
      Network.CAN.CANBasicNW cAN_BasicNW(                 Transmissionrate_intern=
            125, NumberofPorts_intern=4)
        annotation (extent=[-32,0; 14,16]);
      Network.CAN.CANTransceiverModul cAN_TransceiverModul1(
                                                     CAN_Idents_toRcv={40},
        CAN_Ident_toSend=10)
        annotation (extent=[-48,30; -28,50]);
      Network.CAN.CANTransceiverModul cAN_TransceiverModul2(
                                                     CAN_Idents_toRcv={30},
        CAN_Ident_toSend=20)
        annotation (extent=[32,26; 52,46], rotation=180);
      Network.CAN.CANTransceiverModul cAN_TransceiverModul3(
                                                     CAN_Idents_toRcv={20},
        CAN_Ident_toSend=30)
        annotation (extent=[-62,-26; -42,-6], rotation=0);
      Network.CAN.CANTransceiverModul cAN_TransceiverModul4(
        CAN_Ident_toSend=40, CAN_Idents_toRcv={10})
        annotation (extent=[12,-54; 32,-34],  rotation=180);
      Network.CAN.CANRemoteRequestNode cAN_RemoteRequestNode(
        Request_Ident=40,
        Requestperiod=0.1,
        Requestbegin=0.001,
        CAN_Ident_toSend=10) annotation (extent=[-82,30; -62,50]);
      Network.CAN.CANCylicNode cAN_CylicNode(
        CAN_Ident_toSend=20,
        Transmitterperiod=0.1,
        Transmittbegin=0.001,
        i(start=3)) annotation (extent=[68,26; 88,46], rotation=180);
      Network.CAN.CANCylicNode cAN_CylicNode1(
        CAN_Ident_toSend=30,
        Transmitterperiod=0.1,
        Transmittbegin=0.001,
        i(start=5)) annotation (extent=[-94,-26; -74,-6]);
      Network.CAN.CANPassiveNode cAN_PassiveNode(
                                          CAN_Ident_toSend=40, i(start=7))
        annotation (extent=[60,-54; 80,-34], rotation=180);
     equation

      connect(cAN_TransceiverModul1.can_port, cAN_BasicNW.can_port[1])
        annotation (points=[-29.4,40; -18,40; -18,7.66; -9.23,7.66],      style(
            color=3, rgbcolor={0,0,255}));
      connect(cAN_TransceiverModul2.can_port, cAN_BasicNW.can_port[2])
        annotation (points=[33.4,36; 14,36; 14,7.94; -9.23,7.94],style(color=3,
            rgbcolor={0,0,255}));
      connect(cAN_TransceiverModul3.can_port, cAN_BasicNW.can_port[3])
        annotation (points=[-43.4,-16; -26,-16; -26,8.22; -9.23,8.22],
          style(color=3, rgbcolor={0,0,255}));
      connect(cAN_TransceiverModul4.can_port, cAN_BasicNW.can_port[4])
        annotation (points=[13.4,-44; -2,-44; -2,8.5; -9.23,8.5], style(color=3,
            rgbcolor={0,0,255}));
      connect(cAN_CylicNode.messagequeue_connector, cAN_TransceiverModul2.messagequeue_connector)
        annotation (points=[73.7,35.2; 61.85,35.2; 61.85,35.3; 50.2,35.3],
          style(color=2, rgbcolor={0,255,0}));
      connect(cAN_CylicNode1.messagequeue_connector, cAN_TransceiverModul3.messagequeue_connector)
        annotation (points=[-79.7,-15.2; -68.85,-15.2; -68.85,-15.3; -60.2,
            -15.3], style(color=2, rgbcolor={0,255,0}));
      connect(cAN_PassiveNode.messagequeue_connector, cAN_TransceiverModul4.messagequeue_connector)
        annotation (points=[65.7,-44.8; 47.85,-44.8; 47.85,-44.7; 30.2,-44.7],
          style(color=2, rgbcolor={0,255,0}));
      connect(cAN_RemoteRequestNode.messagequeue_connector,
        cAN_TransceiverModul1.messagequeue_connector) annotation (points=[-67.7,
            40.8; -55.85,40.8; -55.85,40.7; -46.2,40.7], style(color=2,
            rgbcolor={0,255,0}));
     end CANExample;
  end Examples;

  package Functions "External C functions and Modelica functions "
    package cFunctions
      model Description

      annotation (DocumentationClass=true, Documentation(info="<html>The functions in Network.Functions.C_Functions are external c functions defined in two libraries: Stringrepository.lib and Queuemanage.lib.
The primary aim of building these two libraries in c is to reduce the model complexities. The functions in Stringrepository handles the problem of exchanging string format information between models. While the
functions in Queuemanagement takes the charge of managing the FIFO queue.  </html>"));

      end Description;

      function c_reservememory

        annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
cacheID = <b>c_reservememory</b>(cacheSize);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This is an external C functions defined in the library QueueManage. By calling this function. A memory block with defined dimension is reserved for the Cache.
A unique cache identifier is returned. The cache identifier is used by other functions concerning Queue management.

</p>

</html>"));

      annotation (Include="#include <Queuemanage.h>  ",Library={"Queuemanage","Stringrepository"});
      input Integer cacheSize;
      output Integer cacheID;
       external  "C"  cacheID =
                              reservememory(cacheSize);
      end c_reservememory;

      function c_enqueue

        annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
 <b>c_enqueue</b>(cacheID, messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This is an external C functions to enqueue the <i>messageID</i> into the corresponding Cache at the first free store place.
Two input arguments are found. <i>cacheID</i> indicates the queue under operation. <i>messageID</i> is the identifier of the to be stored string which is provided by c_createmessage.
</p>
<h3><font color=\"#008000\">Example</font></h3>
enqueue(1,3); <br>
Store the message Nr 3 into the Cache Nr.1 .





</html>"));
      annotation (Include="#include <Queuemanage.h>",
            Library={"Queuemanage","Stringrepository"});
      input Integer cacheID "Identifier of the cache";
      input Integer messageID "Identifier of the Message";
      external  "C" enqueue(cacheID,messageID);

      end c_enqueue;

      function c_createmessage

         annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
 messageID=<b>c_createmessage</b>(inputstr);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This is an external C functions to store string information.  Since the string manipulation in Modelica is constrained only in the function intern,
no string value can be evaluated in the model level. createMessage gives a solution to this problem. The actual content of the string is stored in the memory and managed by the external library,
only the unique message ID is used in Modelica to identify the corresponding String.

</p>
<h3><font color=\"#008000\">Example</font></h3>
messageID=createmessage(\"This is a message\"); <br>


</html>"));
        annotation (Include="#include <StringRepository.h>",Library={"StringRepository"});

        input String inputstr="test" "The string to be stored";

        output Integer messageID "The unique ID to indicate the string ";

      external "C" messageID =
                             createmessage(
                inputstr);

      end c_createmessage;

      function c_readmessage

          annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
 outputstring=<b>c_readmessage</b>(messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This is an external C functions to read string information. Again the same problem,  since the string can not be handeled in Model level. This function can be only used as a underlying function for further information parse.
Given is the Message ID, and the content represented in String is returned.
.
</p>
<h3><font color=\"#008000\">Example</font></h3>
outputstring=c_readmessage(1); <br>


</html>"));
        annotation (Include="#include <StringRepository.h>",
            Library={"StringRepository"});

        input Integer messageID;
        output String outputstring;

      external "C" outputstring = readmessage(messageID);

      end c_readmessage;

      function c_dequeue

        annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
 messageID=<b>c_dequeue</b>(cacheID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This is an external C functions to dequeue the first <i>messageID</i> from the corresponding FIFO Cache and shift the rest entries in the cache of one position to beginning. Since the cache stores only the identifiers of messages, the return value is a Integer number.
The dequeued message is duplicated and the original message is deleted by memory management. Thus,  the return value <i>messageID</i> is different from the original ID of the frist message in Cache although they have the same content.

</p>
<h3><font color=\"#008000\">Example</font></h3>messageID=c_dequeue(1); <br>
Get the first Message id from cache Nr.1.

</html>"));
      annotation (Include="#include <Queuemanage.h>",
            Library={"Queuemanage","Stringrepository"});
      input Integer cacheID;
      output Integer messageID;
      external  "C" messageID =
                              dequeue(cacheID);

      end c_dequeue;

      function c_readcacheindex

          annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
 index=<b>c_readcacheindex</b>(cacheID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This is an external C functions to assess the actual index pointer of the corresponing cache. The index pointer indicate the first free store position in the cache.
The index of the cache is used to indicate the cache status, e.g. whether the cache is full or empty

</p>
<h3><font color=\"#008000\">Example</font></h3>
index=ReadCacheIndex(1); <br>
Get the actual index of  cache Nr.1.

</html>"));
        annotation (Include="#include <Queuemanage.h>",
            Library={"Queuemanage","Stringrepository"});
      input Integer cacheID;
      output Integer index;

      external "C" index =
                         readcacheindex(cacheID);
      end c_readcacheindex;

    function c_duplicatemessage

    annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
 copies=<b>c_duplicatemessage</b>(messageID,numberOfCopies);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This is an external C functions to make copies of the original message. The number of copies is given by the input argument 'numberOfCopies'.
Return value is an array which stores the message identifiers of copies. <b>original message will be deleted after duplication</b>
</p>
<h3><font color=\"#008000\">Example</font></h3>
copies=c_duplicatemessage(1,4); <br>
Make 4 copies of message Nr.1.

</html>"));
    annotation (Include="#include <StringRepository.h>",
          Library={"StringRepository"});

    input Integer messageID;
    input Integer numberOfCopies;
    output Integer copies[numberOfCopies];

    external "C" duplicatemessage(messageID,numberOfCopies,copies);

    end c_duplicatemessage;

    function c_enqueuehead

      annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
 <b>c_enqueue</b>(cacheID, messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This is an external C functions to enqueue the <i>messageID</i> into the corresponding Cache at the first free store place.
Two input arguments are found. <i>cacheID</i> indicates the queue under operation. <i>messageID</i>
is the identifier of the to be stored string which is provided by c_createmessage.
<br><b>ATTENTION:each call of the function will delete the original message to release the memory consumption.</b>
</p>
<h3><font color=\"#008000\">Example</font></h3>
enqueue(1,3); <br>
Store the message Nr 3 into the Cache Nr.1 .





</html>"));

    annotation (Include="#include <Queuemanage.h>",
          Library={"Queuemanage","Stringrepository"});
    input Integer cacheID "Identifier of the cache";
    input Integer messageID "Identifier of the Message";
    external  "C" enqueuehead(cacheID,messageID);

    end c_enqueuehead;
    end cFunctions;

    package FrameFunctions
      "Package contains functions for network frame handling"
    model Description
     annotation (DocumentationClass=true, Documentation(info="<html>
The functions in Network.Functions.Frame_Functions parse and extract information from the structured Frame defined in <a href=Modelica://Network.DataStructure.Frame>Frame</a>.
 </html>"));
    equation

    end Description;

      function readMessage

      annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
outputString = <b>readMessage</b>(messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function returns the actual content of the message acoording to the input message ID. <br>
Notice that the string can not be handled in the model level thus this function can not be used outside of another function.
<br>


</p>
</html>"));
        input Integer messageID;
      protected
       output String outputString;

      algorithm
        outputString :=Network.Functions.cFunctions.c_readmessage(
                                                 messageID);
          Modelica.Utilities.Streams.print("String: " + outputString,  "");
      end readMessage;

      function readData

      annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
data = <b>readData</b>(messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function returns the \"data \" field as <font color=\"#ff0000\">String</font> of the message in form of <a href=\"Modelica://Network.DataStructure.Frame\"  ><font color=\"#ff0000\">Network.DataStructure.Frame</font></a>.


</p>
</html>"));
        input Integer messageID;

        output String data;

      protected
        String message;
        Integer splitter[4];
        Integer endofinputstr;

      algorithm
        (message) := Network.Functions.FrameFunctions.readMessage(messageID);
        endofinputstr := Modelica.Utilities.Strings.length(message);

        splitter[1] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                1);
        splitter[2] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                splitter[1] + 1);
        splitter[3] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                splitter[2] + 1);
        splitter[4] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                splitter[3] + 1);

      data := Modelica.Utilities.Strings.substring(
                message,
                splitter[3] + 1,
                splitter[4] - 1);

      end readData;

      function readLength

      annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
length = <b>readLength</b>(messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function returns the \"length \" field as <font color=\"#ff0000\">Integer</font> of the message in form of <a href=\"Modelica://Network.DataStructure.Frame\"  ><font color=\"#ff0000\">Network.DataStructure.Frame</font></a>.


</p>
</html>"));

        input Integer messageID;

        output Integer length;

      protected
        String message;
        Integer splitter[4];
        Integer endofinputstr;

      algorithm
        (message) := Network.Functions.FrameFunctions.readMessage(messageID);
        endofinputstr := Modelica.Utilities.Strings.length(message);

        splitter[1] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                1);
        splitter[2] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                splitter[1] + 1);
        splitter[3] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                splitter[2] + 1);
        splitter[4] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                splitter[3] + 1);

      length := Modelica.Utilities.Strings.scanInteger(
          Modelica.Utilities.Strings.substring(
                message,
                splitter[4] + 1,
              endofinputstr));

      end readLength;

      function readDestinationAddress

      annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
destinationAddress = <b>readDestinationAddress</b>(messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function returns the \"Destination address \" field as <font color=\"#ff0000\">Integer</font> of the message in form of <a href=\"Modelica://Network.DataStructure.Frame\"  ><font color=\"#ff0000\">Network.DataStructure.Frame</font></a>.


</p>
</html>"));
        input Integer messageID;
        output Integer destinationAddress;

      protected
        String message;
        Integer splitter[2];
        Integer endofinputstr;

      algorithm
        (message) := Network.Functions.FrameFunctions.readMessage(messageID);
        endofinputstr := Modelica.Utilities.Strings.length(message);

        splitter[1] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                1);
        splitter[2] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                splitter[1] + 1);

        destinationAddress := Modelica.Utilities.Strings.scanInteger(
          Modelica.Utilities.Strings.substring(
                message,
                splitter[1] + 1,
                splitter[2] - 1));

      end readDestinationAddress;

      function readSourceAddress
      annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
sourceAddress = <b>readSourceAddress</b>(messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function returns the \"Source address \" field as <font color=\"#ff0000\">Integer</font> of the message in form of <a href=\"Modelica://Network.DataStructure.Frame\"  ><font color=\"#ff0000\">Network.DataStructure.Frame</font></a>.


</p>
</html>"));
        input Integer messageID;
        output Integer sourceAddress;

      protected
        String message;
        Integer splitter[2];
        Integer endofinputstr;

      algorithm
        (message) := Network.Functions.FrameFunctions.readMessage(messageID);
        endofinputstr := Modelica.Utilities.Strings.length(message);

        splitter[1] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                1);
        splitter[2] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                splitter[1] + 1);

        sourceAddress:= Modelica.Utilities.Strings.scanInteger(
          Modelica.Utilities.Strings.substring(
                message,
                1,
                splitter[1] - 1));

      end readSourceAddress;

      function duplicateMessage
              annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
copies= <b>duplicateMessage(messageID,numberOfCopies)</b>(messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function returns an array which stores all the message identifiers of copies. Original Message is deleted after the function call.
This function is useful when handeling broadcasting message. since each call of enqueue() will delete the original message in order to release
memory consumption </font></a>.


</p>
</html>"));
            input Integer messageID;
            input Integer numberOfCopies;
            output Integer copies[numberOfCopies];

      algorithm
              copies:=Network.Functions.cFunctions.c_duplicatemessage(messageID, numberOfCopies);

      end duplicateMessage;
    end FrameFunctions;

  end Functions;

  package Interfaces "Necessary connectors."
    connector ICConnector

    annotation(Documentation(info="<html>General connector between controller and network component. A wrapper connector of
<b><a href=Modelica://Network.Cache.CacheBusConnector>CacheBusConnector</b></a>. It supplies a symbolic connection between controller task and
Network Tranceivermodul.
<p>The two variables on the connector are <font color=\"#ff0000\"> IC_Connector.cacheBus_Connector.SendCache_ID</font> and <font color=\"#ff0000\">IC_Connector.cacheBus_Connector.RcvCache_ID</font>.
They are two seperate cache identifiers defined by the Transceiver modul.   </p>






 </html>"),     Icon(
          Polygon(points=[-96,36; 0,36; -16,2; -76,2; -96,36], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[-56,22; -52,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-50,22; -46,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-44,22; -40,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-38,22; -34,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-32,22; -28,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-26,22; -22,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-56,14; -52,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-50,14; -46,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-44,14; -40,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-38,14; -34,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-32,14; -28,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-26,14; -22,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-62,22; -58,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-20,22; -16,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[40,22; 44,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[46,22; 50,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[52,22; 56,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[58,22; 62,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[64,22; 68,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[70,22; 74,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[40,14; 44,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[46,14; 50,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[52,14; 56,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[58,14; 62,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[64,14; 68,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[70,14; 74,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[34,22; 38,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[76,22; 80,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[-68,14; -64,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-62,14; -58,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-74,22; -70,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-68,22; -64,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[28,22; 32,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[22,22; 26,26], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[34,14; 38,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[28,14; 32,18], style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Polygon(points=[4,36; 100,36; 84,2; 24,2; 4,36], style(color=2, rgbcolor={0,255,0}))),
        Diagram(
          Polygon(points=[-106,0; -10,0; -26,-34; -86,-34; -106,0],
                                                               style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[-66,-14; -62,-10],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-60,-14; -56,-10],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-54,-14; -50,-10],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-48,-14; -44,-10],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-42,-14; -38,-10],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-36,-14; -32,-10],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-66,-22; -62,-18],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-60,-22; -56,-18],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-54,-22; -50,-18],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-48,-22; -44,-18],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-42,-22; -38,-18],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-36,-22; -32,-18],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-72,-14; -68,-10],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-30,-14; -26,-10],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[30,-14; 34,-10],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[36,-14; 40,-10],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[42,-14; 46,-10],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[48,-14; 52,-10],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[54,-14; 58,-10],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[60,-14; 64,-10],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[30,-22; 34,-18],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[36,-22; 40,-18],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[42,-22; 46,-18],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[48,-22; 52,-18],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[54,-22; 58,-18],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[60,-22; 64,-18],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[24,-14; 28,-10],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[66,-14; 70,-10],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[-78,-22; -74,-18],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-72,-22; -68,-18],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-84,-14; -80,-10],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[-78,-14; -74,-10],
                                           style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Ellipse(extent=[18,-14; 22,-10],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[12,-14; 16,-10],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[24,-22; 28,-18],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Ellipse(extent=[18,-22; 22,-18],
                                         style(
              color=2,
              rgbcolor={0,255,0},
              fillColor=2,
              rgbfillColor={0,255,0})),
          Polygon(points=[-6,0; 90,0; 74,-34; 14,-34; -6,0],
                                                           style(color=2, rgbcolor={0,255,0})),
          Text(
            extent=[-104,-38; 122,-108],
            style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              fillColor=68,
              rgbfillColor={170,213,255}),
            string="To Controller")));

      Network.Cache.CacheBusConnector cacheBusConnector
        "CacheBus_Connector contains two caches, one for send data, another for receive data"
        annotation (extent=[-40,-4; 24,40]);
    end ICConnector;

    connector ZigBeePort

    extends Network.Interfaces.NetworkPort;

      annotation (Documentation( info="<html>sub class of <a href= Modelica://Network.Interfaces.Network_Port>Network_Port</a>, for ZigBee transmission. </html>"),Icon(Ellipse(extent=[-54,46; 54,-62], style(
              color=3,
              rgbcolor={0,0,255},
              thickness=4,
              fillPattern=1)), Text(
            extent=[-112,46; 110,-66],
            string="Z",
            style(
              color=7,
              rgbcolor={255,255,255},
              thickness=4,
              fillPattern=1))), Diagram);
    end ZigBeePort;

    partial connector NetworkPort
      Boolean mediumBusy
        "The state of the shared medium, not used in Ethernet port";
      Boolean transmitting(start=false)
        "If a message is actually being transmitting, this signal is true";
      Boolean portBusy
        "not used in Ethernet portIndicate the status of the Port, idle or busy";
      Boolean incommingFrame(start=false)
        "Event indicator, a incomming message";
      Boolean transmittTrying(start=false)
        "Transmitt attempt, used in CSMA/CA, to decide a collision.  not used in Ethernet port";
      Boolean conflictMA "Collision in medium, not used in Ethernet port";
      Boolean successfulTransmission(start=true)
        "Indicator of finished transmission";
      Network.Cache.CacheBusConnector cacheBusConnector
        annotation (extent=[-18,-102; 26,-62]);
      annotation (Documentation(info="<html>Network Port is a general connector for the network communication.

It defines the necessary state variables for indicating events and passes the Cache identifiers between network components.
Network port is the super class for <a href=Modelica://Network.Interfaces.ZigBee_Port>ZigBee_Port</a>,
<a href=Modelica://Network.Interfaces.Etherent_Port>Ethernet_Port</a> , <a href=Modelica://Network.Interfaces.WLAN_Port>WLAN_Port</a>.
<p>


</p>
</html>"),
    Diagram(Rectangle(extent=[-52,52; 54,-60], style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              arrow=1,
              fillColor=42,
              rgbfillColor={127,0,0})),
                                   Text(
            extent=[-118,116; 122,50],
            style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              arrow=1,
              fillColor=42,
              rgbfillColor={127,0,0}),
            string="%name")), Icon);

    end NetworkPort;

    connector WLANPort
      extends Network.Interfaces.NetworkPort;

      annotation (Documentation(info="<html>sub class of <a href= Modelica://Network.Interfaces.Network_Port>Network_Port</a>, for WLAN transmission.</html>"),Icon(
          Text(
            extent=[-70,-20; 74,-96],
            style(color=3, rgbcolor={0,0,255}),
            string="WLAN"),
          Ellipse(extent=[-26,18; 20,-14],style(
              color=3,
              rgbcolor={0,0,255},
              thickness=4)),
          Ellipse(extent=[-46,32; 42,-20], style(
              color=3,
              rgbcolor={0,0,255},
              thickness=4)),
          Ellipse(extent=[-64,50; 62,-30], style(
              color=3,
              rgbcolor={0,0,255},
              thickness=4)),
          Rectangle(extent=[-84,10; 90,-34], style(
              color=7,
              rgbcolor={255,255,255},
              fillColor=7,
              rgbfillColor={255,255,255}))));
    end WLANPort;

    connector EthernetPort
    annotation (Documentation( info="<html>Ethernet_Port is a simplified <a href= Modelica://Network.Interfaces.Network_Port>Network_Port</a> which consists of three variables. The rest unused variable will be automatically removed in the simulation
 the unused variables are : Medium_Busy, Conflict_MA,Port_Busy,Transmitt_trying
  </html>"), Icon(
          Polygon(points=[-34,16; -34,-34; 30,-34; 30,16; 18,16; 18,26; 8,26; 8,
                36; -12,36; -12,26; -22,26; -22,16; -34,16],
                                                         style(
              color=3,
              rgbcolor={0,0,255},
              thickness=4)),
          Line(points=[-26,-24; -26,-34],
                                        style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Line(points=[-22,-24; -22,-34],
                                        style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Line(points=[18,-24; 18,-34],
                                      style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Line(points=[24,-24; 24,-34],
                                      style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Line(points=[-10,-24; -10,-34],
                                      style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Line(points=[-4,-24; -4,-34],
                                      style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Line(points=[2,-24; 2,-34],
                                    style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Line(points=[8,-24; 8,-34], style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Rectangle(extent=[-82,76; 80,-62],  style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Text(
            extent=[-46,-74; 40,-100],
            style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2),
            string="%name")));
      //extends Network_Port(Medium_Busy=false,Conflict_MA=false,Port_Busy=false,Transmitt_trying=false);
      extends Network.Interfaces.NetworkPort;

    /* Ethernet_Port is a simplified network port which consists of three variables. The rest unused variable will be automatically removed in the simulation

 the unused variables are : Medium_Busy, Conflict_MA,Port_Busy,Transmitt_trying*/

      annotation (Icon);
    end EthernetPort;

    connector CANPort

    Boolean Medium_Busy;
    Boolean Incomming_Frame(start=false);
    Boolean Transmitt_trying(start=false);
    Boolean Conflict_MA;
    Boolean Successful_Transmission(start=true);
    Cache.CacheBusConnector CacheBusConnector
        annotation (extent=[-18,-102; 26,-62]);
      annotation (Documentation(info="<html>Network Port is a general connector for the network communication. It defines the necessary state variables for indicating events and passes the Cache identifiers between network components. Network port is the super class for Zigbee port, ethernet port , wlan port </html>"),Diagram(Rectangle(extent=[-52,52; 54,-60], style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              arrow=1,
              fillColor=42,
              rgbfillColor={127,0,0})),
                                   Text(
            extent=[-118,116; 122,50],
            style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              arrow=1,
              fillColor=42,
              rgbfillColor={127,0,0}),
            string="%name")), Icon);

    end CANPort;
  end Interfaces;

  package DataStructure "Predefined data structures."
  annotation(Documentation( info= "<html>These records are only used to illustrate the predefined Message, Frame structure. </html>"));
    record SendMessage "Message structure of raw Message from controller."

      annotation (preferedView="info",Documentation(info="<html><br><font size=5> This record defines the general structure of a rawdata from controller. The structrue is shown in the following table. <br>
  </font><br>

<table border=3 cellpadding=2 cellspacing=5  bordercolor=\"#111111\" width=85% id=AutoNumber1>

  <tr>
    <td width=30%><font color=\"#ff0000\">Integer</font> destinationAddress</td>
    <td width=70%>Destination address </td>
  </tr>
  <tr>
    <td width=30%><font color=\"#ff0000\">Integer</font> operation</td>
    <td width=70%>General description of the message, it can be assigned with value to indicate the operation of this message, e.g. read, update and etc.</td>
  </tr>
  <tr>
    <td width=30%><font color=\"#ff0000\">String</font> data</td>
    <td width=70%>The actual data of the message</td>
  </tr>

</table>
<br>
In this generic structrue, essential parts in the communication are already included.
Use \"Operation\" to define the function of the message,e.g. \"R\" means read sensor value and etc. <br>
<br><font size=+2><b>This structrue is utilized by all the external functions , should always be kept.</b></font>
</html>"));

      Integer destinationAddress;
      //Destination Address
      Integer operation;
      // indicate the type of frame in ZigBee transmission, for establish the connection or acknowledge or data.
      String data;
      // the actual data
    end SendMessage;

    record Frame "Data Structure of the network frame."

      annotation (preferedView="info",Documentation(info="<html><br><font size=5> This record defines the general structure of a Frame in the network transmission. The structrue is shown in the following table. </font><br>

<table border=3 cellpadding=2 cellspacing=5  bordercolor=\"#111111\" width=85% id=AutoNumber1>
  <tr>
    <td width=20%><font color=\"#ff0000\">Integer</font> sourceAddress</td>
    <td width=80%>Source address from the transmitting node </td>
  </tr>
  <tr>
    <td width=20%><font color=\"#ff0000\">Integer</font> destinationAddress</td>
    <td width=80%>Destination address </td>
  </tr>
  <tr>
    <td width=20%><font color=\"#ff0000\">Integer</font> operation</td>
    <td width=80%>General description of the message, it can be assigned with value to indicate the operation of this message, e.g. read, update and etc.</td>
  </tr>
  <tr>
    <td width=20%><font color=\"#ff0000\">String</font> data</td>
    <td width=80%>The actual data of the message</td>
  </tr>
<tr>
    <td width=20%><font color=\"#ff0000\">Integer</font> messageLength</td>
    <td width=80%>The length of the message, unit in Byte</td>
  </tr>
</table>
<br>
The content parts 2 to 4 are provided by controller. Source address is provided by the interface module. The message length is calculated with the actual length of the rawdata and overall header of protocol <br>
<br><font size=+2><b>This structrue is utilized by all the functions in <a href =Modelica://Network.Functions.Frame_Functions>Functions.Frame_Functions</a> , should always be kept.</b></font>
</html>"));
      Integer sourceAddress;
      // Source Address
      Integer destinationAddress;
      //Destination Address
      Integer operation;
      // indicate the type of frame in ZigBee transmission, for establish the connection or acknowledge or data.
      String data;
      // the actual data
      Integer messageLength;
      // The actual Message Length
    end Frame;

    record RcvMessage
      "Message structure of the received message in controller."

      annotation (preferedView="info",Documentation(info="<html><br><font size=5> This record defines the general structure of a decapsulated data from network to controller. The structrue is shown in the following table. <br>
  </font><br>

<table border=3 cellpadding=2 cellspacing=5  bordercolor=\"#111111\" width=85% id=AutoNumber1>

  <tr>
    <td width=30%><font color=\"#ff0000\">Integer</font> sourceAddress</td>
    <td width=70%>Source address </td>
  </tr>
  <tr>
    <td width=30%><font color=\"#ff0000\">Integer</font> operation</td>
    <td width=70%>General description of the message, it can be assigned with value to indicate the operation of this message, e.g. read, update and etc.</td>
  </tr>
  <tr>
    <td width=30%><font color=\"#ff0000\">String</font> data</td>
    <td width=70%>The actual data of the message</td>
  </tr>

</table>
<br>
<br>
<br><font size=+2><b>This structrue is utilized by all the external functions , should always be kept.</b></font>
</html>"));

      Integer sourceAddress;
      //Destination Address
      Integer operation;
      // indicate the type of frame in ZigBee transmission, for establish the connection or acknowledge or data.
      String data;
      // the actual data
    end RcvMessage;

     record CANFrame

      annotation (preferedView="info",Documentation(info="<html><br><font size=5> This record defines the general structure of a Frame in a CAN Network . The structrue is shown in the following table. </font><br>

<table border=3 cellpadding=2 cellspacing=5  bordercolor=\"#111111\" width=85% id=AutoNumber1>
  <tr>
    <td width=20%><font color=\"#ff0000\">Integer</font> CAN_Ident</td>
    <td width=80%>The CAN Identifier indicates the content and the priority of the Message</td>
  </tr>
  <tr>
    <td width=20%><font color=\"#ff0000\">String</font> Operation</td>
    <td width=80%>General description of the CAN message, it can be assigned with value to indicate the operation of this message</td>
  </tr>
  <tr>
    <td width=20%><font color=\"#ff0000\">String</font> Data</td>
    <td width=80%>The actual data of the message</td>
  </tr>
<tr>
    <td width=20%><font color=\"#ff0000\">Integer</font> MessageLength</td>
    <td width=80%>The length of the message, unit in Byte</td>
  </tr>
</table>
<br>
 The message length is calculated with the actual length of the rawdata and overall header of protocol. <br>
<br><font size=+2><b>This structrue is utilized by all the external functions , should always be kept.</b></font>
</html>"));

      Integer CAN_Ident;
      // indicates content and priority of CAN-Message
      String Operation;
      // indicate the type of frame: "C"for Cyclic, "RR" for Remote Request, "ARR" for Answer to Remote Request, "E" Error Frame
      String Data;
      // the actual data
      Integer MessageLength;
      // The actual Message Length

     end CANFrame;
  end DataStructure;

  package CommonComponents
    "Components which are defined as partial and used in several different models"
      partial model CSMACAmedium

      import Network.Functions;

      annotation (Documentation(info=
                                   "<html>General CSMA/CA wireless communication medium for an Ad-Hoc network. Network node, which is located in the network enviroment , should be connected with the network port provided by the CSMA_CA medium.
    The number of network nodes can be configured in this model.

<br><br> In this model, the network address and the network port number are <b>equivalent</b>. i.e. If a transceiver model connected to network port 1, it should have the same network address 1.
 </html>"),                                                                     Diagram);

      Integer tryingnodes[internNumberOfPorts];
      // if the nth node is trying to send, then tryingnode[n]=1 else =0;

        replaceable Network.Interfaces.NetworkPort networkPort[
                                                        internNumberOfPorts]
                                            annotation (choicesAllMatching,                     style(
           pattern=3),
          extent=[-8,-6; 6,8]);                                                                                            //Internal ports to represent the medium.

      Integer activenode;     //The node which is now sending ;
      Integer destinationNode;  // Actually, every node receives the same message, but to save resouce, only the node with correspond destination address will receive a flag to store the message.
      Boolean incommingFrame[internNumberOfPorts];  // Indicate which node receive the comming message flag.
      Boolean portConnected[internNumberOfPorts];   // state variable to indicate the connection status of the connector.

      // The three public variables below are connected with  all connectors.
      ///////
      Boolean mediumBusy(start=false);

      Boolean conflictMA;

      Boolean successfulTransmission;
      ///////

      Integer messageInTransmission;  // The identifier of the message in transmission

      Real transmissionduration "transmission duration for each packet";

    protected
      Integer sumOfTryingnodes;  // how many nodes are trying to send at the same time point
      Modelica.SIunits.Time transmittingBegin; //  begin time of a transmission
      Modelica.SIunits.Time conflictTimer; // the time point of a conflict
      Modelica.SIunits.Time transmissionEnd; // the time point of a successful transmission
      parameter Integer internNumberOfPorts "Number of connected ports";
      parameter Integer internTransmissionRate "Transmission rate (kbps)";
      parameter Real internDIFS "Distributed Interframe Space , unit in 's'";
      parameter Boolean internIntermedia "exist intermediate system or not";
      parameter Integer internIntermediaSystemAddress
        "if there is a intermediate system, with which port is it connected";

      equation
      //Initialization:  scan alll connected ports, if not connected, assign constant values to the port.
      when initial() then
        for i in 1:internNumberOfPorts loop
            if cardinality(networkPort[i]) == 0 then
              networkPort[i].cacheBusConnector.sendCacheID = -1;
              networkPort[i].cacheBusConnector.rcvCacheID = -1;
              networkPort[i].transmittTrying = false;
              networkPort[i].transmitting = false;
              networkPort[i].portBusy = false;
              portConnected[i] = false;
            else
              portConnected[i] = true;
               end if;
        end for;
      end when;

      // The values of public varaibles are assigned to every connector in every simulation step
      for  i in 1:internNumberOfPorts loop
       networkPort[i].mediumBusy = pre(mediumBusy);
       networkPort[i].conflictMA = pre(conflictMA);
       networkPort[i].successfulTransmission = pre(successfulTransmission);
       networkPort[i].incommingFrame = pre(incommingFrame[i]); // flag of incomming message for each port.
      end for;

      // if any node is active, the transmitting message can be received by other nodes, if no node is active , no message in medium

      // if it concerns about assigning values to a vector in a loop,it can not be implemented as a iterative loop in the algorithm part.
      // solution here is to define some auxiliary variable and put them in equation part

      algorithm

      if time>0 then   // since all the information exchange is based on the cache model, cache will be set up after time 0 so all the operation is taken place after time 0
          //Initial, waiting for triggering, if any node is trying to send, register the node in the array tryingnodes[]
        for i in 1:internNumberOfPorts loop
           if portConnected[i] == true then  //only check the connected port
           // incommingFrame[i]:= false;
             when (networkPort[i].transmittTrying) then
              //when requested, register the node which is trying to send
               tryingnodes[i] := 1;

             end when;
           end if;
        end for;
         sumOfTryingnodes :=sum(tryingnodes);
        //Got the sum of tryingnodes[]

        //more than one node is trying to send , conflict state set.
        when (sumOfTryingnodes)  > 1 then
         //if more than one nodes are trying to send, set a conflictTimer
         mediumBusy := true;
         conflictTimer := time;
         conflictMA := true;
         successfulTransmission := false;

        end when;

        // only one is active, set the state to allow transmission
        when (sumOfTryingnodes)  == 1 then
          // if only one node is trying to send, permit and acknowledge
         mediumBusy := true;
         transmittingBegin  := time;
         conflictMA := false;
         successfulTransmission := false;
          for
           i in 1:internNumberOfPorts loop
            //find the active node which is trying to send
             if tryingnodes[i] == 1 then
               activenode := i;
             end if;
          end for;
              messageInTransmission:=Network.Cache.CacheFunctions.dequeue(
                                                       networkPort[activenode].cacheBusConnector.sendCacheID);

        transmissionduration := Network.Functions.FrameFunctions.readLength(
                                                     messageInTransmission)*8/internTransmissionRate/1000;
        end when;

        // recover from conflict state
        when time > conflictTimer + internDIFS then
         // conflict timer reset.
         mediumBusy := false;
         tryingnodes := zeros(internNumberOfPorts);
         conflictMA := false;
         successfulTransmission := false;
        end when;

        // recover from succesful transmimssion and inform the destination node.
        if transmittingBegin  > 0 then
         // transmission finished timer reset.

           when time > transmittingBegin  + (transmissionduration) then
         transmissionEnd:=time;

           for i in 1:internNumberOfPorts loop
             //find the active node which is trying to send
             if tryingnodes[i] == 1 then
               activenode := i;
               if (messageInTransmission) > 0 then
                  if internIntermedia == true then
                    if activenode == internIntermediaSystemAddress then
                 destinationNode := Network.Functions.FrameFunctions.readDestinationAddress(
                   messageInTransmission);
                    elseif activenode <> internIntermediaSystemAddress then
                    destinationNode:=internIntermediaSystemAddress;
                    end if;
                  end if;
                  if internIntermedia == false then
           destinationNode := Network.Functions.FrameFunctions.readDestinationAddress(
                   messageInTransmission);
                  end if;

               end if;

               if (destinationNode) <> 0 then

                 incommingFrame[destinationNode] := true;
                 Network.Cache.CacheFunctions.enqueue(
                                   networkPort[destinationNode].cacheBusConnector.rcvCacheID, messageInTransmission);

               end if;
             end if;
           end for;
           tryingnodes := zeros(internNumberOfPorts);
           end when;
        end if;

        if pre(transmissionEnd) > 0 then
          when time > transmissionEnd + internDIFS then
            mediumBusy := false;
            conflictMA := false;
            successfulTransmission := true;
            incommingFrame[destinationNode] := false;
          end when;
        end if;

      end if;
      //Graphical information

      annotation (Icon(
         Ellipse(extent=[-48,32; 48,-32], style(
             color=3,
             rgbcolor={0,0,255},
             pattern=3)),
         Ellipse(extent=[-56,42; 54,-40], style(
             color=3,
             rgbcolor={0,0,255},
             pattern=3)),
         Ellipse(extent=[-62,48; 62,-46], style(
             color=3,
             rgbcolor={0,0,255},
             pattern=3)),
         Ellipse(extent=[-40,24; 40,-24], style(
             color=3,
             rgbcolor={0,0,255},
             pattern=3)),
         Ellipse(extent=[-28,16; 26,-14], style(
             color=3,
             rgbcolor={0,0,255},
             pattern=3)),
         Ellipse(extent=[-74,60; 76,-56], style(
             color=3,
             rgbcolor={0,0,255},
             pattern=3)),
         Ellipse(extent=[-84,66; 86,-64], style(
             color=3,
             rgbcolor={0,0,255},
             pattern=3)),
         Ellipse(extent=[-92,72; 94,-72], style(
             color=3,
             rgbcolor={0,0,255},
             pattern=3))),            Diagram);
      end CSMACAmedium;

    partial model CSMACAtransceivermodul

      annotation (Documentation(info="<html>This is a primary transceiver modul which serves as the interface between controller and network.
  Transceiver modul consists four caches for data and network messages. The encapsulate and decapsulate mechanismus convert the data format.
<p> The IC_Connector pass the identifiers of Data caches (Send, Receive) to the controller model. And the identifiers of Frame caches (Send, Receive) are passed to the
  medium model.</p> </html>"),
       Diagram,
        Icon(
          Rectangle(extent=[46,58; 58,-84],  style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Ellipse(extent=[36,-74; 68,-96], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Polygon(points=[46,58; 46,60; 48,66; 48,80; 50,82; 52,84; 56,80; 56,
                66; 58,58; 46,58],  style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1)),
          Ellipse(extent=[36,76; 68,64], style(color=3, rgbcolor={0,0,255})),
          Ellipse(extent=[20,82; 86,54],  style(color=3, rgbcolor={0,0,255})),
          Ellipse(extent=[6,88; 98,44],   style(color=3, rgbcolor={0,0,255})),
          Line(points=[42,-82; 30,-90; 30,-82; 28,-82; 24,-84; 20,-84; 14,-82;
                8,-86; 10,-90; -2,-94; -6,-94; -6,-90; -2,-88; 0,-78],
              style(
              color=3,
              rgbcolor={0,0,255},
              thickness=4,
              fillPattern=1))));

      import Network.Functions;
      extends Network.CommonComponents.PartialTransceivermodul;
      Integer backoffExponent(start=internInitBE) "initial Backoff exponent";
      Integer numberOfBackoff(start=internInitNB) "initial number of backoff";

      Real randomNumber;
      Real backoffTimes;

      Boolean internlTransmittingTrying(start=false);
      Modelica.SIunits.Time beginOfBackoff;
      Modelica.SIunits.Time randomWaitingBeforeSending;

    Integer sendCacheIndex;
    Integer rcvCacheIndex;
    protected
    parameter Integer internSourceAddress
        "Network addresss of this transceivermodul";
    parameter Integer internMaxBE "maximum Backoff Exponent" annotation (Evaluate=true);
     parameter Real internUnitBackoffPeriod
        "20 symbol period,4 bit per symbol period, unit 's'";
    parameter Integer internMaxNB "maximum number of backoff";
    parameter Integer internInitBE
        "initial value of backoffExponent of each transmission";
    parameter Integer internInitNB
        "initial value of numberOfBackoff of each transmission";
    parameter Integer internCacheSize;
    parameter Integer internTransmissionRate;
    parameter String internDetailedProtocol
                                       annotation(Evaluation=true);
    public
    Boolean frozenBackoff;
    Real remainBackoff;

      Cache.Cache messageSendCache(cacheSize=64)
                                annotation (extent=[-84,14; -14,46]);
      Cache.Cache messageRcvCache(cacheSize=64)
                               annotation (extent=[-16,-12; -86,-44]);
      Cache.Cache frameSendCache(cacheSize=64)
                                 annotation (extent=[16,14; 84,46]);
      Cache.Cache frameRcvCache(cacheSize=64)
                                annotation (extent=[84,-12; 16,-44]);
      Encapsulate encapsulate(sourceAddress=internSourceAddress)
                              annotation (extent=[-26,44; 20,2]);
      Decapsulate decapsulate annotation (extent=[-26,2; 22,-40], rotation=180);
      Cache.CacheBUS cacheBUS annotation (extent=[-66,10; -54,-14]);
      Cache.CacheBUS cacheBUS1 annotation (extent=[66,12; 56,-16]);
    equation
      randomNumber= RandomUniform(time);

    algorithm

    if time>0 then
      if internDetailedProtocol=="802.11" then
        if Network.Cache.CacheFunctions.readCacheIndex( frameSendCache.cacheID) >= 1 then//if cache is not empty
          if pre(networkPort.transmitting)==false then
            if pre(networkPort.mediumBusy) == false then
              //if medium is  free
              if pre(networkPort.conflictMA) == false then
                if pre(networkPort.transmittTrying) ==  false then
                  if pre(internlTransmittingTrying)==false then
                    // if is not in transmitting_trying
                  internlTransmittingTrying:=true;
                    //try to transmitt
                  end if;
                end if;
             end if;
            end if;
          end if;
      end if;
    end if;

    if internDetailedProtocol=="802.15" then
      if Network.Cache.CacheFunctions.readCacheIndex(     frameSendCache.cacheID) >= 1 then
        if pre(internlTransmittingTrying)==false then
          if pre(networkPort.transmittTrying) ==  false then
            if pre(networkPort.transmitting)==false then
              internlTransmittingTrying:=true;
            end if;
          end if;
        end if;
      end if;
    end if;

    when pre(internlTransmittingTrying)==true then
      beginOfBackoff :=time;
      if frozenBackoff==false then
        backoffTimes:=ceil(randomNumber*(2^backoffExponent -1));
        randomWaitingBeforeSending:= backoffTimes * internUnitBackoffPeriod;
      elseif frozenBackoff ==true then
        randomWaitingBeforeSending:= remainBackoff;
      end if;
    end when;

    if internDetailedProtocol=="802.11" then  //only ieee802.11 need to interrupt the backoff
      if (beginOfBackoff) >0 then
        if (time> beginOfBackoff) and (time< randomWaitingBeforeSending+ beginOfBackoff) then
          when (networkPort.mediumBusy) then
            frozenBackoff:=true;
            remainBackoff:= randomWaitingBeforeSending + beginOfBackoff - time;
            internlTransmittingTrying:=false;
          end when;
        end if;
      end if;
    elseif internDetailedProtocol=="802.15" then
      frozenBackoff:=false;
      remainBackoff:=0;
    end if;

    if pre(beginOfBackoff)>0 then
      if (internlTransmittingTrying)==true then
        when (time) >pre(randomWaitingBeforeSending)+pre(beginOfBackoff) then
          frozenBackoff:=false;
          if (networkPort.mediumBusy) == false then
            networkPort.transmittTrying := true;
            networkPort.transmitting := false;
            internlTransmittingTrying:=false;
          else
            backoffExponent:=backoffExponent + 1;
              if backoffExponent > internMaxBE then
                 backoffExponent:= internMaxBE;
              end if;
              numberOfBackoff:= numberOfBackoff + 1;
              if numberOfBackoff > internMaxNB then
                terminate("medium access failure");
              end if;
            internlTransmittingTrying:=false;
          end if;
        end when;
      end if;
    end if;

    if (networkPort.transmittTrying) == true then // in the transmitt trying phase
      when pre(networkPort.conflictMA)  and pre(networkPort.mediumBusy) then // if conflict is detected, stop trying and set retry time,
            backoffExponent:= backoffExponent + 1;
            if backoffExponent > internMaxBE then
               backoffExponent:= internMaxBE;
            end if;
            numberOfBackoff:= numberOfBackoff + 1;
            if numberOfBackoff > internMaxNB then
               terminate("medium access failure");
            end if;
            networkPort.transmittTrying := false;
            internlTransmittingTrying:=false;
            networkPort.transmitting := false;
      end when;
    end if;

    if (networkPort.transmittTrying) == true then // in the transmitt trying phase
      if (networkPort.transmitting)==false then
        when (networkPort.mediumBusy) then // if the medium allow to trying
          if (networkPort.conflictMA) == false then       // if no conflict
            sendCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(     frameSendCache.cacheID);
            networkPort.transmittTrying := false;
            internlTransmittingTrying:=false;
            networkPort.transmitting := true;
            networkPort.portBusy := true;
            backoffExponent:= internInitBE;
            numberOfBackoff:= internInitNB;
          end if;
        end when;
      end if;
    end if;

    if (networkPort.transmitting) == true then
      when not (networkPort.mediumBusy) and (networkPort.successfulTransmission) then
          networkPort.transmitting := false;
          networkPort.transmittTrying := false;
          networkPort.portBusy := false;
          internlTransmittingTrying:=false;
       end when;
    end if;

      /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
    when (networkPort.incommingFrame) then
      networkPort.portBusy := true;
      rcvCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(     frameRcvCache.cacheID);
    end when;

    end if;

    equation

      connect(messageSendCache.cacheConnector, cacheBUS.sendCache) annotation (points=
           [-49.35,23.12; -49.35,14.56; -59.76,14.56; -59.76,5.8], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4,
          gradient=1,
          fillColor=68,
          rgbfillColor={170,213,255}));
      connect(cacheBUS.rcvCache, messageRcvCache.cacheConnector) annotation (points=[
            -60,-11.48; -60,-20; -50,-21.12; -50.65,-21.12], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4,
          gradient=1,
          fillColor=68,
          rgbfillColor={170,213,255}));
      connect(frameSendCache.cacheConnector, cacheBUS1.sendCache) annotation (
          points=[49.66,23.12; 49.66,18.56; 60.8,18.56; 60.8,7.1], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4,
          gradient=1,
          fillColor=68,
          rgbfillColor={170,213,255}));
      connect(messageSendCache.cacheConnector, encapsulate.sourceCache) annotation (
          points=[-49.35,23.12; -32.675,23.12; -32.675,20.48; -14.96,20.48], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4,
          gradient=1,
          fillColor=68,
          rgbfillColor={170,213,255}));
      connect(encapsulate.destinationCache, frameSendCache.cacheConnector)
        annotation (points=[7.58,20.48; 29.79,20.48; 29.79,23.12; 49.66,23.12],
          style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4,
          gradient=1,
          fillColor=68,
          rgbfillColor={170,213,255}));
      connect(messageRcvCache.cacheConnector, decapsulate.destinationCache)
        annotation (points=[-50.65,-21.12; -32.325,-21.12; -32.325,-20.26; -14,
            -20.26], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4,
          gradient=1,
          fillColor=68,
          rgbfillColor={170,213,255}));
      connect(decapsulate.sourceCache, frameRcvCache.cacheConnector) annotation (
          points=[9.52,-20.68; 29.76,-20.68; 29.76,-21.12; 50.34,-21.12], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4,
          gradient=1,
          fillColor=68,
          rgbfillColor={170,213,255}));
      connect(cacheBUS1.rcvCache, frameRcvCache.cacheConnector) annotation (points=[61,
            -13.06; 60,-14; 60,-21.12; 50.34,-21.12],    style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4,
          gradient=1,
          fillColor=68,
          rgbfillColor={170,213,255}));
      connect(cacheBUS1.cacheBusConnector, networkPort.cacheBusConnector)
        annotation (points=[65.15,-3.54; 65.15,36.23; 52.32,36.23; 52.32,75.62],
          style(
          color=74,
          rgbcolor={0,0,127},
          thickness=4));
      connect(cacheBUS.cacheBusConnector, iCConnector.cacheBusConnector)
        annotation (points=[-64.98,-3.32; -64.98,-26.66; -50.08,-26.66; -50.08,
            -73.58], style(
          color=74,
          rgbcolor={0,0,127},
          thickness=4));
    end CSMACAtransceivermodul;

    partial model CSMACAintermedia

      annotation (Documentation(info="<html>Intermedia model execuets the same protocol as the tranceivermodul. The only difference is that Intermedia model has no connection
            to controller. The network message comes into receive cache will be simply duplicated to Send cache and transmitted again.    </html>"),
                                                                  Diagram,
        Icon(
          Rectangle(extent=[46,58; 58,-84],  style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Ellipse(extent=[36,-74; 68,-96], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Polygon(points=[46,58; 46,60; 48,66; 48,80; 50,82; 52,84; 56,80; 56,
                66; 58,58; 46,58],  style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1)),
          Ellipse(extent=[36,76; 68,64], style(color=3, rgbcolor={0,0,255})),
          Ellipse(extent=[20,82; 86,54],  style(color=3, rgbcolor={0,0,255})),
          Ellipse(extent=[6,88; 98,44],   style(color=3, rgbcolor={0,0,255})),
          Line(points=[46,-78; 30,-90; 30,-78; 24,-72; 18,-68; 10,-70; 6,-74; 6,
                -78; 4,-84; 2,-90; -2,-90; -6,-86; -10,-84; -16,-80],
              style(
              color=3,
              rgbcolor={0,0,255},
              thickness=4,
              fillPattern=1)),
          Polygon(points=[-82,-64; -86,-64; -100,-78; -8,-78; 4,-64; -82,-64],
              style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1)),
          Rectangle(extent=[-100,-78; -8,-90], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Polygon(points=[-8,-90; 4,-76; 4,-64; -8,-78; -8,-78; -8,-90], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1)),
          Polygon(points=[-38,-66; -50,-72; -20,-72; -28,-72; -20,-66; -38,-66],
              style(
              color=0,
              rgbcolor={0,0,0},
              gradient=2,
              fillColor=1,
              rgbfillColor={255,0,0},
              fillPattern=7)),
          Polygon(points=[-50,-72; -50,-78; -28,-78; -28,-72; -50,-72], style(
              color=0,
              rgbcolor={0,0,0},
              gradient=2,
              fillColor=1,
              rgbfillColor={255,0,0},
              fillPattern=7)),
          Polygon(points=[-28,-78; -20,-72; -20,-66; -28,-72; -28,-78], style(
              color=0,
              rgbcolor={0,0,0},
              gradient=2,
              fillColor=1,
              rgbfillColor={255,0,0},
              fillPattern=7))));

      import Network.Functions;
    protected
     parameter Integer internMaxBE "maximum Backoff Exponent";
      parameter Real internUnitBackoffPeriod
        "20 symbol period,4 bit per symbol period, unit 's'";
      parameter Integer internMaxNB "maximum number of backoff";
      parameter Integer internInitBE
        "initial value of backoffExponent of each transmission";
      parameter Integer internInitNB
        "initial value of numberOfBackoff of each transmission";
      parameter Integer internCacheSize;
      parameter Integer internTransmissionRate;
    parameter String internDetailedProtocol
                                       annotation(Evaluation=true);
    public
      Integer backoffExponent(start=internInitBE) "initial Backoff exponent";
      Integer numberOfBackoff(start=internInitNB) "initial number of backoff";
      Real randomNumber;
      Real backoffTimes;
      Boolean frozenBackoff;
      Real remainBackoff;

      Boolean internTransmittingTrying(start=false);
      Modelica.SIunits.Time beginOfBackoff;
      Modelica.SIunits.Time randomWaitingBeforeSending;

      replaceable Network.Interfaces.NetworkPort networkPort
                             extends Network.Interfaces.NetworkPort
                              annotation (extent=[52,76; 68,92]);

    Integer sendCacheIndex;
    Integer rcvCacheIndex;

      Cache.Cache sendCache annotation (extent=[-38,12; 26,56]);
      Cache.Cache rcvCache annotation (extent=[-36,18; 22,-22]);
      Cache.CacheBUS cacheBUS annotation (extent=[20,8; 40,28], rotation=180);
    equation

      randomNumber=RandomUniform(time);

    algorithm

    if time>0 then

    if internDetailedProtocol=="802.11" then
      if Network.Cache.CacheFunctions.readCacheIndex(     cacheBUS.sendCache.cacheID) >= 1 then//if cache is not empty
        if pre(networkPort.transmitting)==false then
          if pre(networkPort.mediumBusy) == false then //if medium is  free
            if pre(networkPort.conflictMA) == false then
              if pre(networkPort.transmittTrying) ==  false then
                if pre(internTransmittingTrying)==false then  // if is not in transmitting_trying
                    internTransmittingTrying:=true;//try to transmitt
                end if;
              end if;
           end if;
          end if;
        end if;
      end if;
    end if;

    if internDetailedProtocol=="802.15" then
      if Network.Cache.CacheFunctions.readCacheIndex(     cacheBUS.sendCache.cacheID) >= 1 then
        if pre(internTransmittingTrying)==false then
          if pre(networkPort.transmittTrying) ==  false then
            if pre(networkPort.transmitting)==false then
              internTransmittingTrying:=true;
            end if;
          end if;
        end if;
      end if;
    end if;

    when pre(internTransmittingTrying)==true then
        beginOfBackoff:=time;
        if frozenBackoff==false then
          backoffTimes:=ceil(randomNumber*(2^backoffExponent-1));
          randomWaitingBeforeSending:=backoffTimes*internUnitBackoffPeriod;
        elseif frozenBackoff==true then
          randomWaitingBeforeSending:=remainBackoff;
        end if;
    end when;

    if internDetailedProtocol=="802.11" then  //only ieee802.11 need to interrupt the backoff
      if pre(beginOfBackoff) >0 then
        if (time>beginOfBackoff) and (time<randomWaitingBeforeSending+beginOfBackoff) then
          when networkPort.mediumBusy then
            frozenBackoff:=true;
            remainBackoff:=randomWaitingBeforeSending + beginOfBackoff - time;
            internTransmittingTrying:=false;
          end when;
        end if;
      end if;
    elseif internDetailedProtocol=="802.15" then
      frozenBackoff:=false;
      remainBackoff:=0;
    end if;

    if pre(beginOfBackoff)>0 then
      if pre(internTransmittingTrying)==true then
        when time >randomWaitingBeforeSending+beginOfBackoff then
          frozenBackoff:=false;
          if (networkPort.mediumBusy) == false then
            networkPort.transmittTrying := true;
            networkPort.transmitting := false;
          else
             backoffExponent:=backoffExponent + 1;
             if backoffExponent>internMaxBE then
               backoffExponent:=internMaxBE;
             end if;
             numberOfBackoff:=numberOfBackoff + 1;
             if numberOfBackoff>internMaxNB then
               terminate("medium access failure");
             end if;
            internTransmittingTrying:=false;
          end if;
        end when;
      end if;
    end if;

    if pre(networkPort.transmittTrying) == true then// in the transmitt trying phase
      when pre(networkPort.conflictMA)  and pre(networkPort.mediumBusy) then      // if conflict is detected, stop trying and set retry time,
           backoffExponent:=backoffExponent + 1;
           if backoffExponent>internMaxBE then
              backoffExponent:=internMaxBE;
           end if;
           numberOfBackoff:=numberOfBackoff + 1;
           if numberOfBackoff>internMaxNB then
              terminate("medium access failure");
           end if;
           networkPort.transmittTrying := false;
           internTransmittingTrying:=false;
           networkPort.transmitting := false;
      end when;
    end if;

    if pre(networkPort.transmittTrying) == true then  // in the transmitt trying phase
      if (networkPort.transmitting)==false then
        when pre(networkPort.mediumBusy) then// if the medium allow to trying
          if (networkPort.conflictMA) == false then       // if no conflict
            sendCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(     cacheBUS.sendCache.cacheID);
            networkPort.transmittTrying := false;
            internTransmittingTrying:=false;
            networkPort.transmitting := true;
            networkPort.portBusy := true;
            backoffExponent:=internInitBE;
            numberOfBackoff:=internInitNB;
          end if;
        end when;
      end if;
    end if;

    if pre(networkPort.transmitting) == true then
        when not (networkPort.mediumBusy) and (networkPort.successfulTransmission) then
          networkPort.transmitting := false;
          networkPort.transmittTrying := false;
          networkPort.portBusy := false;
          internTransmittingTrying:=false;
        end when;
    end if;

      /*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
    when (networkPort.incommingFrame) then
        networkPort.portBusy := true;
        rcvCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(     cacheBUS.rcvCache.cacheID);
        Network.Cache.CacheFunctions.enqueue(     cacheBUS.sendCache.cacheID,Network.Cache.CacheFunctions.dequeue(     cacheBUS.rcvCache.cacheID));
    end when;

    end if;

    equation
      connect(sendCache.cacheConnector, cacheBUS.sendCache) annotation (points=[
            -6.32,24.54; 11.84,24.54; 11.84,24.5; 29.6,24.5], style(color=3,
            rgbcolor={0,0,255}));
      connect(rcvCache.cacheConnector, cacheBUS.rcvCache) annotation (points=[-7.29,
            6.6; 11.355,6.6; 11.355,10.1; 30,10.1],       style(color=3, rgbcolor={
              0,0,255}));
      connect(cacheBUS.cacheBusConnector, networkPort.cacheBusConnector)
        annotation (points=[38.3,16.9; 38.3,47.45; 60.32,47.45; 60.32,77.44], style(
          color=74,
          rgbcolor={0,0,127},
          thickness=4));
    end CSMACAintermedia;

    model Encapsulate
      Network.Cache.CacheConnector sourceCache
        "The Cache ID of the Data Cache, which stores the Raw data from controller"
                                                                                                            annotation (extent=[-62,2; -42,22]);
      Network.Cache.CacheConnector destinationCache
        "The Cache ID of the Frame Cache, which stroes the encapsulated Frame to be transmitted "
                                                                                                            annotation (extent=[36,2; 56,22]);
      annotation (Documentation( info="<html> Encapsulate the raw data with header information according to transmissino protocols. </html>"),Diagram, Icon(
          Text(
            extent=[-90,10; -48,-28],
            style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3),
            string="S"),
          Text(
            extent=[40,8; 82,-30],
            style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3),
            string="D"),
          Rectangle(extent=[-44,48; 38,-34], style(
              color=42,
              rgbcolor={127,0,0},
              gradient=1,
              fillColor=42,
              rgbfillColor={127,0,0})),
          Text(
            extent=[-66,96; 60,42],
            string="%name",
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=4,
              gradient=1,
              fillColor=42,
              rgbfillColor={127,0,0})),
          Line(points=[-56,-72; 64,-72], style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              arrow=1,
              fillColor=42,
              rgbfillColor={127,0,0}))));
    Integer sourceCacheIndex;
    Integer destinationCacheIndex;
    Integer messageInProcessing;
    parameter Integer sourceAddress "Network address of the network interface";

    replaceable function encapsulateframe =
          Network.CommonComponents.TransceiverFunctions.encapsulateFrame  extends
        Network.CommonComponents.TransceiverFunctions.encapsulateFrame
                                          annotation(choicesAllMatching);

    algorithm
    if time>0 then
      sourceCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(     sourceCache.cacheID);
      destinationCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(     destinationCache.cacheID);

      when change(sourceCacheIndex) then
        messageInProcessing:=Network.Cache.CacheFunctions.dequeue(     sourceCache.cacheID);
        messageInProcessing:=encapsulateframe(sourceAddress,messageInProcessing);
        Network.Cache.CacheFunctions.enqueue(     destinationCache.cacheID, messageInProcessing);
      end when;
    end if;
    end Encapsulate;

    model Decapsulate
      Network.Cache.CacheConnector sourceCache
        "The Cache ID of the Frame Cache, which stores the Network Frame from network"
                                                                                                            annotation (extent=[-58,-18; -38,2]);
      Network.Cache.CacheConnector destinationCache
        "The Cache ID of the Data Cache, which stores the Raw data extracted from network frame"
                                                                                                            annotation (extent=[40,-16; 60,4]);
      annotation (Documentation( info="<html>Decapsulate the network frame to a raw data format defined in  <a href=\"Modelica://Network.DataStructure.RcvMessage\"  ><font color=\"#ff0000\"> Network.DataStructure.RcvMessage</font></a>. </html>"),                                                                                                    Diagram, Icon(
          Text(
            extent=[-76,-12; -40,-52],
            style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3),
            string="S"),
          Text(
            extent=[46,-12; 82,-52],
            style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3),
            string="D"),
          Rectangle(extent=[-40,32; 42,-50], style(
              color=42,
              rgbcolor={127,0,0},
              gradient=1,
              fillColor=68,
              rgbfillColor={170,213,255})),
          Text(
            extent=[-62,86; 66,24],
            string="%name",
            style(
              color=0,
              rgbcolor={0,0,0},
              gradient=1,
              fillColor=68,
              rgbfillColor={170,213,255})),
          Line(points=[-66,-80; 64,-80], style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              arrow=1,
              fillColor=42,
              rgbfillColor={127,0,0}))));
    Integer sourceCacheIndex;
    Integer destinationCacheIndex;

    Integer messageInProcessing;

    algorithm
    if time>0 then
      sourceCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(     sourceCache.cacheID);
      destinationCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(     destinationCache.cacheID);
      when change(sourceCacheIndex) then
         messageInProcessing:=Network.Cache.CacheFunctions.dequeue(     sourceCache.cacheID);
          messageInProcessing := Network.CommonComponents.TransceiverFunctions.decapsulateFrame(
            messageInProcessing);
         Network.Cache.CacheFunctions.enqueue(     destinationCache.cacheID, messageInProcessing);
      end when;
    end if;

    end Decapsulate;

    partial model PartialTransceivermodul

      Network.Interfaces.ICConnector iCConnector
        annotation (extent=[-74,-96; -22,-58]);
      replaceable Network.Interfaces.NetworkPort networkPort
        annotation (extent=[44,74; 60,92]);
      annotation (Diagram, Icon(
          Polygon(points=[-56,-54; -60,-54; -74,-68; 18,-68; 30,-54; -56,-54],
              style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1)),
          Rectangle(extent=[-74,-68; 18,-80],  style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Polygon(points=[18,-80; 30,-66; 30,-54; 18,-68; 18,-68; 18,-80],
                                                                         style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1)),
          Polygon(points=[-12,-56; -24,-62; 6,-62; -2,-62; 6,-56; -12,-56],
              style(
              color=0,
              rgbcolor={0,0,0},
              gradient=2,
              fillColor=1,
              rgbfillColor={255,0,0},
              fillPattern=7)),
          Polygon(points=[-24,-62; -24,-68; -2,-68; -2,-62; -24,-62],   style(
              color=0,
              rgbcolor={0,0,0},
              gradient=2,
              fillColor=1,
              rgbfillColor={255,0,0},
              fillPattern=7)),
          Polygon(points=[-2,-68; 6,-62; 6,-56; -2,-62; -2,-68],        style(
              color=0,
              rgbcolor={0,0,0},
              gradient=2,
              fillColor=1,
              rgbfillColor={255,0,0},
              fillPattern=7))));
      parameter Integer sourceAddress
        "Network addresss of this transceivermodul";

    end PartialTransceivermodul;

    package TransceiverFunctions
     model Description
      annotation (DocumentationClass=true, Documentation(info="<html>
The functions in Network.Functions.Transceiver_Functions are modelica functions which fullfil the encapsulation and decapsulation tasks in Interface Model.
 </html>"));
     equation

     end Description;

      function encapsulateFrame

       annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
frameID = <b>encapsulateFrame</b>(sourceAdddress,rawDataID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
Basically, the data structures of different models are not identical. Examples can be found in the <font color=\"#ff0000\">Network.DataStructure</font>.
Since the controller has a data which should be transmitted via network. The consistence of the structured informations should be kept. This task is
executed by this function. It adds appropriate header information to a RAW data from controller to construct a complete network frame. Added information include
:<br> 1. Source Address of the network interface which attached to the controller. <br>2. Overall length  of the Frame in byte.(for assessing the transmission time.)
<br>
This function convert the message in the form of <a href=\"Modelica://Network.DataStructure.SendMessage\"  ><font color=\"#ff0000\">Network.DataStructure.SendMessage</font></a> to message in the form of <a href=\"Modelica://Network.DataStructure.Frame\"  ><font color=\"#ff0000\">Network.DataStructure.Frame</font></a>.
<br>
According to different transmissin protocols. This function is redefined in three functions with corresponding protocols.

</p>

</html>"));
        input Integer sourceAddress "Network Address of the sending node";
        input Integer rawDataID "Identifier of raw data from controller";
        output Integer frameID "Identifier of encapsulated frame";
      protected
        Integer length;
        Integer totalOverhead
          "include the total overhead of the whold protocol stack, different values between protocols";

        String processingString;

      algorithm
      processingString:=Network.Functions.FrameFunctions.readMessage(
                                              rawDataID);
      length:=Modelica.Utilities.Strings.length(processingString) + totalOverhead;

      processingString := String(sourceAddress) + "\t" + processingString+"\t" + String(length);

      frameID := Network.Functions.cFunctions.c_createmessage(
                                             processingString);

      end encapsulateFrame;

      function encapsulateFrameEthernet

      extends Network.CommonComponents.TransceiverFunctions.encapsulateFrame(
            totalOverhead=64);
      end encapsulateFrameEthernet;

      function encapsulateFrameZigBee

      extends Network.CommonComponents.TransceiverFunctions.encapsulateFrame(
            totalOverhead=31);
      end encapsulateFrameZigBee;

      function encapsulateFrameWLAN

      extends Network.CommonComponents.TransceiverFunctions.encapsulateFrame(
            totalOverhead=70);
      end encapsulateFrameWLAN;

      function decapsulateFrame

        annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Data_ID = <b>DecapsulateFrame</b>(RawData_ID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function dose the opposite operation as EncapsulateFrame.
<br>
It converts the message in the form of <a href=\"Modelica://Network.DataStructure.Frame\"  ><font color=\"#ff0000\">Network.DataStructure.Frame</font></a> to message in the form of <a href=\"Modelica://Network.DataStructure.RcvMessage\"  ><font color=\"#ff0000\">Network.DataStructure.RcvMessage</font></a>.
<br>


</p>
</html>"));

        input Integer inputFrameID;
        output Integer dataID "Physic memory address of the message";

      protected
      String processingString;
         Integer splitter[4];
         Integer endofinputstr;
         String segment[2];
         String temp;
      algorithm
        processingString:=Network.Functions.FrameFunctions.readMessage(
                                                inputFrameID);

        endofinputstr := Modelica.Utilities.Strings.length(processingString);

        splitter[1] := Modelica.Utilities.Strings.find(
                processingString,
                "\t",
                1);
        splitter[2] := Modelica.Utilities.Strings.find(
                processingString,
                "\t",
                splitter[1] + 1);
        splitter[3] := Modelica.Utilities.Strings.find(
                processingString,
                "\t",
                splitter[2] + 1);
        splitter[4] := Modelica.Utilities.Strings.find(
                processingString,
                "\t",
                splitter[3] + 1);
      segment[1]:=Modelica.Utilities.Strings.substring(
          processingString,
          1,
          splitter[1] - 1);
      segment[2]:=Modelica.Utilities.Strings.substring(
          processingString,
          splitter[2]+1,
          splitter[4] - 1);
      temp:=segment[1] +"\t" + segment[2];
       dataID:=Network.Functions.cFunctions.c_createmessage(
                                                     temp);
      end decapsulateFrame;

       function encapsulateFrameCAN

       annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Frame_ID = <b>encapsulateFrameCAN</b>(RawData_ID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
The total Overhead of a CAN_Frame depends on the chosen CAN Mode. The <b>Normal</b> or <b>Extended</b> Mode of a CAN Network specifies the total Overhead of a Frame.
For example in <b>Extended</b> Mode, the length of the CAN_Identifier is extended from 11 to 29 Bit.
</p>

</html>"));

        input Integer RawData_ID "Identifier of raw data from controller";
        output Integer Frame_ID "Identifier of encapsulated frame";
      protected
        Integer Length;
        Integer TotalOverhead=8
          "include the total overhead(byte,i.e characters in String) of the whole protocol stack, different values between protocols";
        // depends on the chosen CAN_Mode: "normal" or "extended"
        String Processingstring;

       algorithm
        Processingstring := Network.Functions.FrameFunctions.readMessage(
                                              RawData_ID);
        Length := Modelica.Utilities.Strings.length(Processingstring) +
          TotalOverhead;

        Processingstring := Processingstring + "\t" + String(Length);

        Frame_ID := Network.Functions.cFunctions.c_createmessage(
                                             Processingstring);

       end encapsulateFrameCAN;

      function decapsulateFrameCAN

       annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Data_ID = <b>decapsulateFrameCAN</b>(RawData_ID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function dose the opposite operation as Encapsulate_CAN_Frame.
<br>
It cuts off the length from a CAN_Frame.
<br>


</p>
</html>"));

        input Integer InputFrame_ID;
        output Integer Data_ID "Physic memory address of the message";

      protected
      String Processingstring;
         Integer splitter[3];
         Integer endofinputstr;
         String temp;
      algorithm
        Processingstring:=Network.Functions.FrameFunctions.readMessage(
                                                InputFrame_ID);

        endofinputstr := Modelica.Utilities.Strings.length(Processingstring);

        splitter[1] := Modelica.Utilities.Strings.find(
                Processingstring,
                "\t",
                1);
        splitter[2] := Modelica.Utilities.Strings.find(
                Processingstring,
                "\t",
                splitter[1] + 1);
        splitter[3] := Modelica.Utilities.Strings.find(
                Processingstring,
                "\t",
                splitter[2] + 1);

      temp:=Modelica.Utilities.Strings.substring(
          Processingstring,
          1,
          splitter[3] - 1);

        Data_ID:=Functions.cFunctions.c_createmessage(temp);

      end decapsulateFrameCAN;
    end TransceiverFunctions;
  end CommonComponents;

  package ZigBee "Parameterized ZigBee components"

    model ZigBeePrimaryController
      annotation(Documentation(info="<html>The transceiver_task is a primary controller model with network transmission task.
  it simply send and receive network message cyclically. It is used to demonstrate the functionality of Transceivermodul.  </html>"),
          Icon);
      extends Network.PrimaryController.BasePrimaryController;

    end ZigBeePrimaryController;

    model ZigBeeSharedMedium
    annotation (Documentation(info="<html>Extended from <a href=\"Modelica://Network.Common_Components.CSMA_CA_Medium\"> <font color=\"#ff0000\">Network.Common_Components.CSMA_CA_Medium </font></a> with appropriate parameters set for ZigBee protocol. </html>"), Diagram);
    parameter Integer numberOfPorts=4 "Number of connected ports";
    parameter Integer transmissionRate=250 "Transmission rate (kbps)"
                                                                   annotation (radioButtons=true,choices(
          choice=40 "40kbps",
          choice=64 "64kbps",
          choice=250 "250kbps"));

    parameter Real DIFS=12*4/transmissionRate*1e-3
        "Distributed Interframe space , unit in 's'";
    parameter Boolean intermedia=false "exist intermediate system or not";
    parameter Integer intermediaSystemAddress
        "if there is a intermediate system, with which port is it connected";

      extends Network.CommonComponents.CSMACAmedium(
                                         redeclare
          Network.Interfaces.ZigBeePort networkPort,
                      internNumberOfPorts=numberOfPorts,internTransmissionRate=transmissionRate,internDIFS=DIFS,internIntermedia=intermedia,internIntermediaSystemAddress=intermediaSystemAddress)
        annotation (choicesAllMatching,extent=[-98,-94; 94,96]);
    equation

      annotation (Icon(Text(
            extent=[-96,96; -44,52],
            style(color=3, rgbcolor={0,0,255}),
            string="Z")));
    end ZigBeeSharedMedium;

    model ZigbeeTransceivermodul

         annotation (Documentation(info="<html>Extended from <a href=\"Modelica://Network.Common_Components.CSMA_CA_tranceivermodul\"> <font color=\"#ff0000\">Network.Common_Components.CSMA_CA_tranceivermodul </font></a> with appropriate parameters set for ZigBee protocol. </html>"),
                                                                  Diagram,
        Icon(
          Rectangle(extent=[46,58; 58,-84],  style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Ellipse(extent=[36,-74; 68,-96], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Polygon(points=[46,58; 46,60; 48,66; 48,80; 50,82; 52,84; 56,80; 56,
                66; 58,58; 46,58],  style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1)),
          Ellipse(extent=[36,76; 68,64], style(color=3, rgbcolor={0,0,255})),
          Ellipse(extent=[20,82; 86,54],  style(color=3, rgbcolor={0,0,255})),
          Ellipse(extent=[6,88; 98,44],   style(color=3, rgbcolor={0,0,255})),
          Text(
            extent=[-94,88; -8,-14],
            style(color=3, rgbcolor={0,0,255}),
            string="Z")));

       extends Network.CommonComponents.CSMACAtransceivermodul(   redeclare
          Network.Interfaces.ZigBeePort networkPort,
                                              internMaxBE=maxBE,internUnitBackoffPeriod=unitBackoffPeriod,internMaxNB=maxNB,internInitBE= initBE,internInitNB=initNB,internTransmissionRate=transmissionRate,internCacheSize=cacheSize, internDetailedProtocol= detailedProtocol, internSourceAddress=sourceAddress,
        encapsulate(redeclare function encapsulateframe =
              Network.CommonComponents.TransceiverFunctions.encapsulateFrameZigBee));

    parameter Integer sourceAddress "Network addresss of this transceivermodul";
    parameter Integer maxBE=5 "maximum Backoff Exponent";
    parameter Real unitBackoffPeriod= 20*4/transmissionRate*1e-3
        "20 symbol period,4 bit per symbol period, unit 's'";
    parameter Integer maxNB= 6 "maximum number of backoff";
    parameter Integer initBE= 3 "initial value of BE of each transmission";
    parameter Integer initNB= 0 "initial value of NB of each transmission";
    parameter Integer transmissionRate= 250 annotation(radioButtons=true,choices(
          choice=40 "40kbps",
          choice=64 "64kbps",
          choice=250 "250kbps"));
    parameter Integer cacheSize= 64;
    parameter String detailedProtocol="802.15";
    equation

    end ZigbeeTransceivermodul;

    model ZigBeeCoordinator

       annotation (Documentation(info="<html>Extended from <a href=\"Modelica://Network.Common_Components.CSMA_CA_Intermedia\"> <font color=\"#ff0000\">Network.Common_Components.CSMA_CA_Intermedia </font></a> with appropriate parameters set for ZigBee protocol. </html>"),
      Diagram,
      Icon(Text(
          extent=[-96,94; -2,-4],
          style(color=3, rgbcolor={0,0,255}),
          string="Z")));
    parameter Integer maxBE=5 "maximum Backoff Exponent";
    parameter Real unitBackoffPeriod=20*4/transmissionRate*1e-3
        "20 symbol period,4 bit per symbol period, unit 's'";
    parameter Integer maxNB=6 "maximum number of backoff";
    parameter Integer initBE=3 "initial value of BE of each transmission";
    parameter Integer initNB=0 "initial value of NB of each transmission";
    parameter Integer transmissionRate=250 annotation(radioButtons=true,choices(
        choice=40 "40kbps",
        choice=64 "64kbps",
        choice=250 "250kbps"));
    parameter Integer cacheSize=64;
    parameter String detailedProtocol="802.15";

    annotation (Icon, Diagram);
    extends Network.CommonComponents.CSMACAintermedia( internMaxBE=maxBE,internUnitBackoffPeriod=unitBackoffPeriod,internMaxNB=maxNB,
    internInitBE= initBE,internInitNB=initNB,internTransmissionRate=transmissionRate,internCacheSize=cacheSize,
    internDetailedProtocol=detailedProtocol,
      redeclare Network.Interfaces.ZigBeePort networkPort);

    end ZigBeeCoordinator;
  end ZigBee;

  package WLAN "Parameterized WLAN components"
    model WLANSharedmedium

      annotation (Documentation(info="<html>Extended from <a href=\"Modelica://Network.Common_Components.CSMA_CA_Medium\"> <font color=\"#ff0000\">Network.Common_Components.CSMA_CA_Medium </font></a> with appropriate parameters set for IEEE 802.11 WLAN protocol. </html>"));
       parameter Integer numberOfPorts=4 "Number of connected ports";

      parameter Integer transmissionRate=11000 "Transmission rate (kbps)"
                                                                   annotation (radioButtons=true,choices(
          choice=11000 "11Mbps",
          choice=54000 "54Mbps"));

    parameter Real DIFS=50*1e-6 "Distributed Interframe space , unit in 's'"
     annotation (radioButtons=true,choices(choice= 50*1e-6 "for 11Mbps net", choice=28*1e-6
            "for 54Mbps net"));
    parameter Boolean intermedia=false "exist intermediate system or not";
    parameter Integer intermediaSystemAddress
        "if there is a intermediate system, with which port is it connected";

     Boolean portConnected[numberOfPorts];

      extends Network.CommonComponents.CSMACAmedium(
                                         redeclare Network.Interfaces.WLANPort
          networkPort, internNumberOfPorts=numberOfPorts,internTransmissionRate=transmissionRate,internDIFS=DIFS,internIntermedia=intermedia,internIntermediaSystemAddress=intermediaSystemAddress)
        annotation (choicesAllMatching,extent=[-98,-98; 96,96]);

      annotation (Diagram, Icon(Text(
            extent=[-96,94; -52,58],
            style(color=3, rgbcolor={0,0,255}),
            string="W")));
    end WLANSharedmedium;

    model WLANPrimaryController
      annotation(Documentation(info="<html>The transceiver_task is a primary controller model with network transmission task.
  it simply send and receive network message cyclically. It is used to demonstrate the functionality of Transceivermodul.  </html>"),
          Icon);
       extends Network.PrimaryController.BasePrimaryController;
    equation

    end WLANPrimaryController;

    model WLANTransceivermodul

         annotation (Documentation(info="<html>Extended from <a href=\"Modelica://Network.Common_Components.CSMA_CA_tranceivermodul\"> <font color=\"#ff0000\">Network.Common_Components.CSMA_CA_tranceivermodul </font></a> with appropriate parameters set for IEEE 802.11 WLAN protocol. </html>"),
                                                                  Diagram,
        Icon(
          Rectangle(extent=[46,58; 58,-84],  style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Ellipse(extent=[36,-74; 68,-96], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Polygon(points=[46,58; 46,60; 48,66; 48,80; 50,82; 52,84; 56,80; 56,
                66; 58,58; 46,58],  style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1)),
          Ellipse(extent=[36,76; 68,64], style(color=3, rgbcolor={0,0,255})),
          Ellipse(extent=[20,82; 86,54],  style(color=3, rgbcolor={0,0,255})),
          Ellipse(extent=[6,88; 98,44],   style(color=3, rgbcolor={0,0,255})),
          Text(
            extent=[-88,84; -4,-34],
            style(color=3, rgbcolor={0,0,255}),
            string="W")));

    extends Network.CommonComponents.CSMACAtransceivermodul(   redeclare
          Network.Interfaces.WLANPort networkPort,
                                             internMaxBE=maxBE,internUnitBackoffPeriod=unitBackoffPeriod,internMaxNB=maxNB,internInitBE= initBE,internInitNB=initNB,internTransmissionRate=transmissionRate,internCacheSize=cacheSize, internDetailedProtocol= detailedProtocol, internSourceAddress=sourceAddress,
        encapsulate(redeclare function encapsulateframe =
              Network.CommonComponents.TransceiverFunctions.encapsulateFrameWLAN))
                                                                                                    annotation (extent=[-64,44; -44,64]);

      parameter Integer maxBE=10 "maximum Backoff Exponent";
      parameter Integer sourceAddress
        "Network addresss of this transceivermodul";
      parameter Real unitBackoffPeriod=20*1e-6 "slottime"  annotation(radioButtons=true,choices(choice=20*1e-6
            "for 11Mbps net",                                                                                                   choice=9*1e-6
            "for 54Mbps net"));
      parameter Integer maxNB=9999 "maximum number of backoff"; //actually infinitive for IEEE 802.11
      parameter Integer initBE=5 "initial value of BE of each transmission";
      parameter Integer initNB=0 "initial value of NB of each transmission";
      parameter Integer transmissionRate annotation (radioButtons=true,choices(choice= 11000
            "for 11Mbps net",                                                                                         choice=54000
            "for 54Mbps net"));
      parameter Integer cacheSize=64;
      parameter String detailedProtocol="802.11";
    equation

    end WLANTransceivermodul;

    model WLANAccessPoint

        annotation (Documentation(info="<html>Extended from <a href=\"Modelica://Network.Common_Components.CSMA_CA_Intermedia\"> <font color=\"#ff0000\">Network.Common_Components.CSMA_CA_Intermedia </font></a> with appropriate parameters set for IEEE 802.11 WLANprotocol. </html>"),
                                                                  Diagram,
        Icon(Text(
            extent=[-96,90; 0,-22],
            style(color=3, rgbcolor={0,0,255}),
            string="W")));
      parameter Integer maxBE=10 "maximum Backoff Exponent";
       parameter Real unitBackoffPeriod=20*1e-6 "slottime"  annotation(radioButtons=true,choices(choice=20*1e-6
            "for 11Mbps net",                                                                                                   choice=9*1e-6
            "for 54Mbps net"));
      parameter Integer maxNB=6 "maximum number of backoff";
      parameter Integer initBE=5 "initial value of BE of each transmission";
      parameter Integer initNB=0 "initial value of NB of each transmission";
      parameter Integer transmissionRate annotation (radioButtons=true,choices(choice= 11000
            "for 11Mbps net",                                                                                          choice=54000
            "for 54Mbps net"));
      parameter Integer cacheSize=64;
     parameter String detailedProtocol="802.11";

     extends Network.CommonComponents.CSMACAintermedia(  internMaxBE=maxBE,internUnitBackoffPeriod=unitBackoffPeriod,internMaxNB=maxNB,
    internInitBE= initBE,internInitNB=initNB,internTransmissionRate=transmissionRate,internCacheSize=cacheSize,
    internDetailedProtocol=detailedProtocol,
        redeclare Network.Interfaces.WLANPort networkPort)                                                                                              annotation (extent=[-64,44; -44,64]);

    end WLANAccessPoint;
  end WLAN;

  package Ethernet "Parameterized Ethernet components"

    model Cable "Cable model"

      annotation (Diagram(
          Line(points=[-60,-2; -12,-2; 6,-16; 54,-16],
                                                     style(
              color=1,
              rgbcolor={255,0,0},
              thickness=4)),
          Line(points=[-60,-16; -12,-16; 6,-2; 54,-2], style(
              color=3,
              rgbcolor={0,0,255},
              thickness=4))),   Icon(
          Line(points=[-68,2; -10,2; 10,-12; 60,-12],style(
              color=1,
              rgbcolor={255,0,0},
              thickness=4)),
          Line(points=[-68,-12; -10,-12; 10,2; 60,2],  style(
              color=3,
              rgbcolor={0,0,255},
              thickness=4))));

      annotation (Documentation(info="<html><b>C</b>able is an abstract model of network component, it decides the transmission time dynamically based on the \"Length\" information of the message. cable realizes an intern cross over connection,
<p>Cable model can be simulated with or without connection.</p></html>"));

      import Modelica.SIunits.Time;

      parameter Integer networkBandwidth=100 "Network bandwidth 'Mbps'" annotation (radioButtons=true,choices(
          choice=100 "100Mbps",
          choice=10 "10Mbps"));

    protected
      Time time_LR;
      // "Event Time point when transmission from left to right"
      Time time_RL;
      // "Event Time point when transmission from right to left"
      Time transmissionTime_LR;
      //"Time interval needed for transmission, variable, depends on  network bandwidth and ethernet frame length"
      Time transmissionTime_RL;
      //"Time interval needed for transmission, variable, depends on  network bandwidth and ethernet frame length"

      Boolean connectedPort_R(start=false);
      //internal variable to indicate the connection state
      Boolean connectedPort_L(start=false);
      //are used to clarify the program structure.
      Integer messageInTransmission_LR;
      Integer messageInTransmission_RL;
      Integer sendCacheID_L;
      Integer rcvCacheID_L;
      Integer sendCacheID_R;
      Integer rcvCacheID_R;

    public
      Network.Interfaces.EthernetPort ethernetPort_L
        "Ethernet port on the left side (Graphically)"                                       annotation (extent=[-96,-24; -64,10]);
      Network.Interfaces.EthernetPort ethernetPort_R
        "Ethennet port on the right side (Graphically)"                                       annotation (extent=[58,-24; 90,
            10]);
    equation

    if cardinality(ethernetPort_L) == 0 then
        connectedPort_L = false;//Left side port is not connected
        ethernetPort_L.cacheBusConnector.sendCacheID = -1;// assign the input as a empty frame
        ethernetPort_L.transmitting = false;// no transmitting event
      elseif cardinality(ethernetPort_L) <> 0 then
        connectedPort_L = true;// left side is connected
      end if;

      if cardinality(ethernetPort_R) == 0 then
        connectedPort_R = false;//right side port is not connected
        ethernetPort_R.cacheBusConnector.sendCacheID = -1;// so input is empty
        ethernetPort_R.transmitting = false;// no event
      elseif cardinality(ethernetPort_R) <> 0 then
        connectedPort_R = true;// connected
      end if;

    ethernetPort_L.incommingFrame = ethernetPort_R.successfulTransmission and not pre(ethernetPort_R.successfulTransmission);
      //CommingFrame is an event indicator , inform the arrival of ethernet frame on receiver side.
    ethernetPort_R.incommingFrame = ethernetPort_R.successfulTransmission and not pre(ethernetPort_R.successfulTransmission);
     /*Connections part of Cache_ID*/
    sendCacheID_L=ethernetPort_L.cacheBusConnector.sendCacheID;
    rcvCacheID_L=ethernetPort_L.cacheBusConnector.rcvCacheID;
    sendCacheID_R=ethernetPort_R.cacheBusConnector.sendCacheID;
    rcvCacheID_R=ethernetPort_R.cacheBusConnector.rcvCacheID;

    algorithm

      when pre(ethernetPort_L.transmitting) then

        time_LR := time;
        ethernetPort_L.successfulTransmission := false;
        messageInTransmission_LR:=Network.Cache.CacheFunctions.dequeue(     sendCacheID_L);
        transmissionTime_LR := Network.Functions.FrameFunctions.readLength(       messageInTransmission_LR)/networkBandwidth*8e-6;
        //time with unit of 'second', frame.Length has a unit of byte, and bandwidth of million bits per second

      end when;

      if time_LR >0 then

        when time > (time_LR) + (transmissionTime_LR) then
          ethernetPort_L.successfulTransmission := true;
          Network.Cache.CacheFunctions.enqueue(     rcvCacheID_R,messageInTransmission_LR);
        end when;
      end if;

      when pre(ethernetPort_R.transmitting) then
        time_RL := time;
        ethernetPort_R.successfulTransmission := false;
        messageInTransmission_RL:=Network.Cache.CacheFunctions.dequeue(     sendCacheID_R);
        transmissionTime_RL := Network.Functions.FrameFunctions.readLength(       messageInTransmission_RL)/networkBandwidth*8e-6;
      end when;
      if time_RL>0 then
        when time > (time_RL) + (transmissionTime_RL) then
        Network.Cache.CacheFunctions.enqueue(     rcvCacheID_L,messageInTransmission_RL);
        ethernetPort_R.successfulTransmission := true;
        end when;
      end if;

    equation
      connect(ethernetPort_L, ethernetPort_L) annotation (points=[-80,-7; -80,
            -12.5; -80,-12.5; -80,-7], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(ethernetPort_R, ethernetPort_R) annotation (points=[74,-7; 67,
            -7; 67,-7; 74,-7],
                           style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
    end Cable;

    model EthernetPrimaryController
    annotation(Documentation(info="<html>The transceiver_task is a primary controller model with network transmission task.
  it simply send and receive network message cyclically. It is used to demonstrate the functionality of Transceivermodul.  </html>"));

     extends Network.PrimaryController.BasePrimaryController;

    end EthernetPrimaryController;

    model EthernetTransceiverModul

    annotation (Documentation(info="<html>This is a primary Ethernet Modul which takes the charge of sensing the <br>
common medium and sending messange to following node.  </html>"),
                                                              Diagram,
        Icon(                           Text(
            extent=[-86,8; 0,-28],
            style(
              color=0,
              rgbcolor={0,0,0},
              gradient=3,
              fillColor=3,
              rgbfillColor={0,0,255}),
            string="%name"),
          Polygon(points=[46,72; 58,72; 58,-54; 46,-54; 46,-54; 46,72], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1)),
          Polygon(points=[30,-54; 30,-66; 58,-66; 58,-54; 30,-54], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1))));

    parameter Integer sourceAddress "Network address of the Ethernet modul";

     extends Network.CommonComponents.PartialTransceivermodul(
                                                redeclare
          Network.Interfaces.EthernetPort networkPort);

    public
      Cache.Cache messageSendCache annotation (extent=[-46,22; -6,42]);
      Cache.Cache messageRcvCache annotation (extent=[-46,-4; -6,16]);
      Cache.Cache frameSendCache annotation (extent=[6,22; 46,42]);
      Cache.Cache frameRcvCache annotation (extent=[6,-4; 46,16]);
      Network.CommonComponents.Encapsulate encapsulate(     redeclare function
          encapsulateframe =
            Network.CommonComponents.TransceiverFunctions.encapsulateFrameEthernet,
          sourceAddress=sourceAddress)
        annotation (extent=[-12,16; 8,36]);
      Network.CommonComponents.Decapsulate decapsulate
        annotation (extent=[-12,12; 8,-8], rotation=180);
      Cache.CacheBUS cacheBUS annotation (extent=[44,8; 64,28], rotation=180);
      Cache.CacheBUS cacheBUS1 annotation (extent=[-44,4; -64,24], rotation=180);

    algorithm
    // sending when the medium is free and cache not empty
    if time>0 then

    if networkPort.transmitting == false then
      if networkPort.successfulTransmission then
        if Network.Cache.CacheFunctions.readCacheIndex(     frameSendCache.cacheID) >= 1 then
          networkPort.transmitting := true;
        end if;
      end if;
    end if;

    when pre(networkPort.successfulTransmission) then
      networkPort.transmitting := false;
    end when;

      //if incoming message, store it in the cache
    when (networkPort.incommingFrame) then
          // blank
    end when;

      // request from controller node, update the first message in cache
      end if;
    equation
      connect(messageSendCache.cacheConnector, encapsulate.sourceCache) annotation (
          points=[-26.2,27.7; -17.1,27.7; -17.1,27.2; -7.2,27.2], style(color=3,
            rgbcolor={0,0,255}));
      connect(encapsulate.destinationCache, frameSendCache.cacheConnector)
        annotation (points=[2.6,27.2; 14.3,27.2; 14.3,27.7; 25.8,27.7], style(color=
             3, rgbcolor={0,0,255}));
      connect(messageRcvCache.cacheConnector, decapsulate.destinationCache)
        annotation (points=[-26.2,1.7; -16.1,1.7; -16.1,1.4; -7,1.4], style(color=3,
            rgbcolor={0,0,255}));
      connect(decapsulate.sourceCache, frameRcvCache.cacheConnector) annotation (
          points=[2.8,1.2; 14.4,1.2; 14.4,1.7; 25.8,1.7], style(color=3, rgbcolor={
              0,0,255}));
      connect(frameSendCache.cacheConnector, cacheBUS.sendCache) annotation (
          points=[25.8,27.7; 39.9,27.7; 39.9,24.5; 53.6,24.5], style(color=3,
            rgbcolor={0,0,255}));
      connect(frameRcvCache.cacheConnector, cacheBUS.rcvCache) annotation (points=[25.8,1.7;
            39.9,1.7; 39.9,10.1; 54,10.1],            style(color=3, rgbcolor={0,0,
              255}));
      connect(cacheBUS1.sendCache, messageSendCache.cacheConnector) annotation (
          points=[-53.6,20.5; -35.8,20.5; -35.8,27.7; -26.2,27.7], style(color=3,
            rgbcolor={0,0,255}));
      connect(cacheBUS1.rcvCache, messageRcvCache.cacheConnector) annotation (points=[-54,6.1;
            -54,1.7; -26.2,1.7],           style(color=3, rgbcolor={0,0,255}));
      connect(cacheBUS.cacheBusConnector, networkPort.cacheBusConnector)
        annotation (points=[62.3,16.9; 62.3,46.45; 52.32,46.45; 52.32,75.62], style(
          color=74,
          rgbcolor={0,0,127},
          thickness=4));
      connect(cacheBUS1.cacheBusConnector, iCConnector.cacheBusConnector)
        annotation (points=[-62.3,12.9; -62.3,-18.55; -50.08,-18.55; -50.08,
            -73.58],
          style(
          color=74,
          rgbcolor={0,0,127},
          thickness=4));
    end EthernetTransceiverModul;

    model Switch4Ports
      annotation (Documentation( info="<html> Extended from <a href =Modelica:\\Network.Ethernet.Switch_BASIC> Network.Ethernet.Switch_BASIC </a> with explicitly defined 4 ports.
<p><b>Attention:</b></p>
<p>Only the labeled ports can be connected. Default setting of Source Address Table: Port Number = Network Address</p> </html>"),     Icon(
          Text(
            extent=[-100,68; -82,42],
            style(color=3, rgbcolor={0,0,255}),
            string="1"),
          Text(
            extent=[-40,68; -22,42],
            style(color=3, rgbcolor={0,0,255}),
            string="2"),
          Text(
            extent=[84,68; 102,42],
            style(color=3, rgbcolor={0,0,255}),
            string="4"),
          Text(
            extent=[20,68; 38,42],
            style(color=3, rgbcolor={0,0,255}),
            string="3")),
        Diagram);
     Network.Interfaces.EthernetPort ethernetPort_1
        annotation (extent=[-104,70; -80,98]);
      annotation (Diagram, Icon(      Rectangle(extent=[-100,100; 100,-100],
              style(color=0, rgbcolor={0,0,0}))));
     Network.Interfaces.EthernetPort ethernetPort_2
        annotation (extent=[-58,70; -34,100]);
     Network.Interfaces.EthernetPort ethernetPort_3
        annotation (extent=[18,72; 42,100]);
     Network.Interfaces.EthernetPort ethernetPort_4
        annotation (extent=[78,72; 102,100]);
      extends Network.Ethernet.SwitchBASIC(
                           numOfPorts=4,entriesinSat=4,SAT=[1,1;2,2;3,3;4,4]) annotation (extent=[-2,-86; 18,-66]);
    equation
      if cardinality(ethernetPort_1) == 1 then

        ethernetPort_1.incommingFrame = false;
        ethernetPort_1.successfulTransmission = false;

      elseif cardinality(ethernetPort_1) > 1 then

      end if;

      if cardinality(ethernetPort_2) == 1 then

         ethernetPort_2.incommingFrame = false;
        ethernetPort_2.successfulTransmission = false;

      elseif cardinality(ethernetPort_2) > 1 then

      end if;

      if cardinality(ethernetPort_3) == 1 then

            ethernetPort_3.incommingFrame = false;
        ethernetPort_3.successfulTransmission = false;

      elseif cardinality(ethernetPort_3) > 1 then

      end if;

      if cardinality(ethernetPort_4) == 1 then

           ethernetPort_4.incommingFrame = false;
        ethernetPort_4.successfulTransmission = false;

      elseif cardinality(ethernetPort_4) > 1 then

      end if;

      connect(ethernetPort_1, ethernetPort[1]) annotation (points=[-92,84; -92,
            37.5; -92,-9; -90,-9], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(ethernetPort_2, ethernetPort[2]) annotation (points=[-46,85; -46,
            -3; -90,-3], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(ethernetPort_3, ethernetPort[3]) annotation (points=[30,86; 30,3;
            -90,3], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(ethernetPort_4, ethernetPort[4]) annotation (points=[90,86; 90,10;
            88,10; 88,9; -90,9], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
    end Switch4Ports;

    model Switch8ports

     annotation (Documentation( info="<html> Extended from <a href =Modelica:\\Network.Ethernet.Switch_BASIC> Network.Ethernet.Switch_BASIC </a> with explicitly defined 4 ports. <p><b>Attention:</b></p>
<p>Only the labeled ports can be connected. Default setting of Source Address Table: Port Number = Network Address</p> </html>"),     Icon(
          Text(
            extent=[-100,66; -82,40],
            style(color=3, rgbcolor={0,0,255}),
            string="1"),
          Text(
            extent=[-74,66; -56,40],
            style(color=3, rgbcolor={0,0,255}),
            string="2"),
          Text(
            extent=[-26,66; -8,40],
            style(color=3, rgbcolor={0,0,255}),
            string="4"),
          Text(
            extent=[-48,66; -30,40],
            style(color=3, rgbcolor={0,0,255}),
            string="3"),
          Text(
            extent=[0,66; 18,40],
            style(color=3, rgbcolor={0,0,255}),
            string="5"),
          Text(
            extent=[26,66; 44,40],
            style(color=3, rgbcolor={0,0,255}),
            string="6"),
          Text(
            extent=[78,66; 96,40],
            style(color=3, rgbcolor={0,0,255}),
            string="8"),
          Text(
            extent=[50,66; 68,40],
            style(color=3, rgbcolor={0,0,255}),
            string="7")));
      Network.Interfaces.EthernetPort ethernetPort_1
        annotation (extent=[-100, 68; -82, 100]);
       Network.Interfaces.EthernetPort ethernetPort_2
        annotation (extent=[-74, 68; -56, 100]);
      annotation (Diagram, Icon(      Rectangle(extent=[-100,100; 100,-100],
              style(color=0, rgbcolor={0,0,0}))));
      Network.Interfaces.EthernetPort ethernetPort_3
        annotation (extent=[-48, 68; -30, 100]);
      Network.Interfaces.EthernetPort ethernetPort_4
        annotation (extent=[-24, 68; -8, 100]);
       Network.Interfaces.EthernetPort ethernetPort_5
        annotation (extent=[2, 68; 18, 100]);
      Network.Interfaces.EthernetPort ethernetPort_6
        annotation (extent=[26, 68; 42, 100]);
       Network.Interfaces.EthernetPort ethernetPort_7
        annotation (extent=[52,68; 68,100]);
     Network.Interfaces.EthernetPort ethernetPort_8
        annotation (extent=[78,68; 96,100]);
     extends Network.Ethernet.SwitchBASIC(
                           numOfPorts=8,entriesinSat=8,SAT=[1, 1; 2, 2; 3, 3; 4, 4;5,5;6,6;7,7;8,8]);

    equation
      if cardinality(ethernetPort_1) == 1 then

        ethernetPort_1.incommingFrame = false;
        ethernetPort_1.successfulTransmission = false;

      elseif cardinality(ethernetPort_1) > 1 then

      end if;

      if cardinality(ethernetPort_2) == 1 then

        ethernetPort_2.incommingFrame = false;
        ethernetPort_2.successfulTransmission = false;

      elseif cardinality(ethernetPort_2) > 1 then

      end if;

      if cardinality(ethernetPort_3) == 1 then

        ethernetPort_3.incommingFrame = false;
        ethernetPort_3.successfulTransmission = false;

      elseif cardinality(ethernetPort_3) > 1 then

      end if;

      if cardinality(ethernetPort_4) == 1 then

        ethernetPort_4.incommingFrame = false;
        ethernetPort_4.successfulTransmission = false;

      elseif cardinality(ethernetPort_4) > 1 then

      end if;
      if cardinality(ethernetPort_5) == 1 then

        ethernetPort_5.incommingFrame = false;
        ethernetPort_5.successfulTransmission = false;

      elseif cardinality(ethernetPort_5) > 1 then

      end if;

      if cardinality(ethernetPort_6) == 1 then

        ethernetPort_6.incommingFrame = false;
        ethernetPort_6.successfulTransmission = false;

      elseif cardinality(ethernetPort_6) > 1 then

      end if;

      if cardinality(ethernetPort_7) == 1 then

        ethernetPort_7.incommingFrame = false;
        ethernetPort_7.successfulTransmission = false;

      elseif cardinality(ethernetPort_7) > 1 then

      end if;

      if cardinality(ethernetPort_8) == 1 then

        ethernetPort_8.incommingFrame = false;
        ethernetPort_8.successfulTransmission = false;
      elseif cardinality(ethernetPort_8) > 1 then

      end if;
      connect(ethernetPort_1, ethernetPort[1]) annotation (points=[-91,84; -90,
            84; -90,-10.5],
                        style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(ethernetPort_2, ethernetPort[2]) annotation (points=[-65,84; -65,
            42; -90,42; -90,-7.5],
                                style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(ethernetPort_3, ethernetPort[3]) annotation (points=[-39,84; -39,
            42; -90,42; -90,-4.5],
                                style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(ethernetPort_4, ethernetPort[4]) annotation (points=[-16,84; -16,
            -1.5; -90,-1.5],   style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(ethernetPort_5, ethernetPort[5]) annotation (points=[10,84; 8,84;
            8,2; -90,2; -90,1.5],
                              style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(ethernetPort_6, ethernetPort[6]) annotation (points=[34,84; 36,84;
            36,4.5; -90,4.5],style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(ethernetPort_7, ethernetPort[7]) annotation (points=[60,84; 62,84;
            62,7.5; -90,7.5],style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(ethernetPort_8, ethernetPort[8]) annotation (points=[87,84; 87,
            10.5; -90,10.5],
                       style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
    end Switch8ports;

    partial model SwitchBASIC

      import Network.Functions;

      annotation (
        Documentation(info="<html> The Switch_BASIC model is a master class. It defines a array of connectors.Thus a arbitrary number of nodes can be connected
to the switch model. The internal processing time in Switch model is ignored. i.e. switch executes the routing function to forward the network message
to the destination port.
<br> <br>
<b><font size=\"4\">SAT format</font></b><br><br>
The <b>S</b>ource <b>A</b>ddress <b>T</b>able defines the switching rules of the switch.  It is a one dimenrional array with two columns.
In the first colunm, there are network address of transceivers and the second column regists the corresponding port. E.g.

<table border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: collapse\" bordercolor=\"#111111\" width=\"20%\"  height=\"57\">
  <tr>
    <td width=\"50%\" height=\"19\">1</td>
    <td width=\"50%\" height=\"19\">1</td>
  </tr>
  <tr>
    <td width=\"50%\" height=\"19\">2</td>
    <td width=\"50%\" height=\"19\">3</td>
  </tr>
  <tr>
    <td width=\"50%\" height=\"17\">3</td>
    <td width=\"50%\" height=\"17\">4</td>
  </tr>
  <tr>
    <td width=\"50%\" height=\"17\">...</td>
    <td width=\"50%\" height=\"17\">...</td>
  </tr>
</table>
<br> This sat defines that the transceiver model which has the address 1, is connected with switch port 1. The transceiver model which has the address 2 is connected with port 3.
<br> The number of entries in SAT and the SAT itself are parameters that should be defined before the simulation.

</html>"),
        Icon(
            Rectangle(extent=[-100,10; 100,-100],    style(color=3, rgbcolor=
                  {0,0,255})),
          Polygon(points=[-50,-50; -50,-70; 50,-70; 50,-50; 70,-30; -30,-30;
                -50,-50],
                      style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Line(points=[-50,-50; 50,-50], style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Line(points=[70,-30; 70,-50; 50,-70], style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Polygon(points=[-12,-64; -12,-58; -10,-58; -10,-56; -8,-56; -8,-54;
                -4,-54; -4,-56; -2,-56; -2,-58; 0,-58; 0,-64; -12,-64],
                                                                     style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Polygon(points=[-30,-64; -30,-58; -28,-58; -28,-56; -26,-56; -26,-54;
                -22,-54; -22,-56; -20,-56; -20,-58; -18,-58; -18,-64; -30,-64],
                                                                            style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Polygon(points=[6,-64; 6,-58; 8,-58; 8,-56; 10,-56; 10,-54; 14,-54;
                14,-56; 16,-56; 16,-58; 18,-58; 18,-64; 6,-64],
                                                             style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Polygon(points=[26,-64; 26,-58; 28,-58; 28,-56; 30,-56; 30,-54; 34,
                -54; 34,-56; 36,-56; 36,-58; 38,-58; 38,-64; 26,-64],
                                                                 style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Ellipse(extent=[-26,-66; -24,-68], style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Ellipse(extent=[12,-68; 10,-66], style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Ellipse(extent=[-8,-66; -6,-68], style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2)),
          Ellipse(extent=[34,-68; 32,-66], style(
              color=3,
              rgbcolor={0,0,255},
              thickness=2))),
        Diagram);

      import Modelica.SIunits.Time;
       parameter Integer numOfPorts "Number of Ports";
       parameter Integer entriesinSat
        "The number of entires in the Source Address Table";
       parameter Integer SAT[entriesinSat, 2]
        "Source Address Table , first column is the network address, second column is the physical port, labeled from left to right";
       parameter Integer cacheSize "Cache size of each port";

      Boolean tempTransmitting[numOfPorts]; //supplementary variables to support the assginment of values inside a connector.
      Boolean tempTransmissionfinished[numOfPorts]; //supplementary variables to support the assginment of values inside a connector.

      Integer targetPort;
      Integer messageInTransmission;

      Cache.Cache sendCache[numOfPorts](cacheSize=cacheSize)
                                        annotation (extent=[-10,-76; 42,-48]);
      Cache.Cache rcvCache[numOfPorts](cacheSize=cacheSize)
                                       annotation (extent=[-10,-70; 42,-98]);
      Cache.CacheBUS cacheBUS[numOfPorts] annotation (extent=[36,-82; 56,-62],
                                                                             rotation=180);
      Network.Interfaces.EthernetPort ethernetPort[
                                             numOfPorts]
        "Array of ethernet ports"                                                  annotation (Hide=true,
          extent=[-102,-12; -78,12]);
    equation

    for i in 1:numOfPorts loop
    //supplementary variables to support the assginment of values inside a connector.
        ethernetPort[i].transmitting = pre(tempTransmitting[i]);
        tempTransmissionfinished[i] = ethernetPort[i].successfulTransmission;

    end for;

    algorithm

    if time>0 then

      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    for i in 1:numOfPorts loop
        if Network.Cache.CacheFunctions.readCacheIndex(     rcvCache[i].cacheID) >= 1 then
           messageInTransmission:=Network.Cache.CacheFunctions.dequeue(     rcvCache[i].cacheID);
           targetPort := Network.Ethernet.SwitchFunctions.getTargetPort(  SAT,Network.Functions.FrameFunctions.readDestinationAddress(       messageInTransmission));
           Network.Cache.CacheFunctions.enqueue(  sendCache[targetPort].cacheID,messageInTransmission);
        end if;
    end for;

     //if the caches are not empty, try to send out the cached message if the medium is free.  Here is also possible to realize a cyclic transmisison.

    for i in 1:numOfPorts loop
        if tempTransmitting[i] == false then
          if Network.Cache.CacheFunctions.readCacheIndex(     sendCache[i].cacheID) >= 1 then
            if tempTransmissionfinished[i] then
             tempTransmitting[i]:=true;
            end if;
          end if;
        end if;
    end for;

    for i in 1:numOfPorts loop
      when pre(tempTransmissionfinished[i]) then
         tempTransmitting[i] := false;
      end when;
    end for;

    end if; // end if time>0

    equation
      connect(sendCache.cacheConnector, cacheBUS.sendCache) annotation (points=[15.74,
            -68.02; 31.87,-68.02; 31.87,-65.5; 45.6,-65.5],   style(
          color=3,
          rgbcolor={0,0,255},
          thickness=2));
      connect(rcvCache.cacheConnector, cacheBUS.rcvCache) annotation (points=[15.74,
            -77.98; 31.87,-77.98; 31.87,-79.9; 46,-79.9],   style(
          color=3,
          rgbcolor={0,0,255},
          thickness=2));
      connect(ethernetPort.cacheBusConnector, cacheBUS.cacheBusConnector)
        annotation (points=[-89.52,-9.84; 66.2,-9.84; 66.2,-73.1; 54.3,-73.1],style(
          color=74,
          rgbcolor={0,0,127},
          thickness=4));
    end SwitchBASIC;

    package SwitchFunctions
      function getTargetPort
      annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
TargetPort = <b>GetTargetPort</b>(Routingtable[], DestinationAddress);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function serching in the given Routingtable to find the target port to which the messge should be forwarded.
It is used by <font color=\"#ff0000\"> Network.Ethernet.Switch_BASIC</font> and all its sub models.


</p>
</html>"));

            input Integer routingTable[:, 2];
            input Integer address;
            output Integer port;

      protected
            Integer dimensions[2];
      algorithm
            dimensions := size(routingTable);
            port := -1;
            for i in 1:dimensions[1] loop
              if (routingTable[i, 1] == address) then
                port := routingTable[i, 2];

              end if;
            end for;

      end getTargetPort;
    end SwitchFunctions;
  end Ethernet;

  package Cache "Cache model with connectors"
    model Cache
     parameter Integer cacheSize = 64 "The dimension of the Cache";
     Integer cacheID;
      annotation (Icon(
          Rectangle(extent=[-60,20; 58,-34], style(color=3, rgbcolor={0,0,255})),
          Text(
            extent=[-60,64; 56,24],
            style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3),
            string="%name"),
          Line(points=[40,20; 40,-34], style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3)),
          Line(points=[20,20; 20,-34], style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3)),
          Line(points=[0,20; 0,-34],   style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3)),
          Line(points=[-20,20; -20,-34],
                                     style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3)),
          Line(points=[-40,20; -40,-34], style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3)),
          Text(
            extent=[44,8; 52,-26],
            style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3),
            string="1"),
          Text(
            extent=[24,8; 32,-26],
            style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3),
            string="2"),
          Text(
            extent=[4,8; 12,-26],
            style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3),
            string="3"),
          Text(
            extent=[-16,8; -8,-26],
            style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3),
            string="4"),
          Text(
            extent=[-34,8; -26,-26],
            style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3),
            string="..."),
          Text(
            extent=[-52,8; -44,-26],
            style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3),
            string="n")), Diagram);
    annotation (Documentation(info="<html> A cache is a pre-defined memory block to save String format data. Cache is identified by the CacheID. <br>
CacheID is a integer number begin with 0. This parameter should be passed to other models or functions which concern the operation of the Cache.  </html>"));

      Network.Cache.CacheConnector cacheConnector
        "Use this connector to feed back the Cache ID"                              annotation (extent=[-12,-56; 10,-30]);
    algorithm
    when time>0 then
      cacheID:=Network.Cache.CacheFunctions.createCache(     cacheSize);
      cacheConnector.cacheID:=cacheID;
    end when;

    end Cache;

    connector CacheConnector
      annotation (Icon(Rectangle(extent=[-78,36; 76,-98], style(
              color=3,
              rgbcolor={0,0,255},
              gradient=3,
              fillColor=74,
              rgbfillColor={0,0,127})), Text(
            extent=[-92,34; 86,114],
            style(
              color=42,
              rgbcolor={127,0,0},
              gradient=1,
              fillColor=42,
              rgbfillColor={127,0,0}),
            string="%name")));

    Integer cacheID "The connector for passing the unique ID of the cache";
    end CacheConnector;

    model CacheBUS
    annotation (Documentation(info="<html>Cache bus is a model designed to simplified the wiring of cache models. It merges the two cache connectors into a single one.
The cache model which is connected with RcvCache connector, is then visible in the Cache bus connector under the name cacheBus_connector.RcvCache_ID. The same is for the Sendcache </html>"));
      Network.Cache.CacheConnector rcvCache "Receive cahce connector"
                                                         annotation (extent=[-26,64; 26,94]);
      Network.Cache.CacheConnector sendCache "Send cache connector"
                                                       annotation (extent=[-22,-50; 30,-80]);
      annotation (Diagram,               Icon(
          Text(
            extent=[-60,14; -14,2],
            style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              fillColor=74,
              rgbfillColor={0,0,127}),
            string="BUS"),
          Line(points=[0,64; 0,14; -66,14], style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              fillColor=62,
              rgbfillColor={0,127,127})),
          Line(points=[0,-50; 0,0; -66,0], style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              fillColor=62,
              rgbfillColor={0,127,127}))));
      Network.Cache.CacheBusConnector cacheBusConnector "Cache bus connector"
                        annotation (extent=[-108,-8; -58,30]);
    equation
      cacheBusConnector.sendCacheID=sendCache.cacheID;
      cacheBusConnector.rcvCacheID=rcvCache.cacheID;

    end CacheBUS;

    connector CacheBusConnector
    annotation (Documentation( info="<html>A Cache Bus connector connect two caches, one is defined as send cache and the other is defined as the receive one. <br>
The matching with the single cache component is automatically finished by the Cache bus. Thus ,for the controller or other components who access the cache, the send and receive cache are uniquelly assigned.</html>"));

    Integer sendCacheID "The ID of the Send Cache.";
    Integer rcvCacheID "The ID of the Receive Cache.";

      annotation (Icon(Rectangle(extent=[-70,44; 68,-82], style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              fillColor=62,
              rgbfillColor={0,127,127})), Text(
            extent=[-92,134; 100,22],
            style(
              color=74,
              rgbcolor={0,0,127},
              thickness=4,
              gradient=1,
              fillColor=74,
              rgbfillColor={0,0,127}),
            string="CacheBusConnector")));
    end CacheBusConnector;

    package CacheFunctions
      model Description
      annotation (DocumentationClass=true, Documentation(info="<html>
The functions in Network.Functions.Cache_Functions are modelica functions which concern the FIFO queue management.
 </html>"));
      equation

      end Description;

      function dequeue

       annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Message_ID = <b>Dequeue</b>(CacheID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function is the wrap function of C_Functions.c_dequeue in Modelica.
</p>





</html>"));
      input Integer Cache_ID;
      output Integer Message_ID;
      algorithm
        Message_ID := Network.Functions.cFunctions.c_dequeue(
                                                      Cache_ID);
      end dequeue;

      function enqueue
       annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
<b>Enqueue</b>(CacheID,Message_ID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function is the wrap function of C_Functions.c_enqueue in Modelica.
</p>


</html>"));
        input Integer Cache_ID;
      input Integer Message_ID;
      algorithm
        Network.Functions.cFunctions.c_enqueue(
                                        Cache_ID, Message_ID);
      end enqueue;

      function createCache
       annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Cache_ID = <b>CreateCache</b>(CacheSize);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function is the wrap function of C_Functions.c_reservememory in Modelica.
</p>





</html>"));

        discrete input Integer CacheSize;

        discrete output Integer Cache_ID;

      algorithm
        Cache_ID := Network.Functions.cFunctions.c_reservememory( CacheSize);

      end createCache;

      function readCacheIndex
       annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
index = <b>ReadCacheIndex</b>(CacheID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function is the wrap function of C_Functions.c_readcacheindex in Modelica.
</p>





</html>"));
        input Integer Cache_ID;
      output Integer index;
      algorithm
        index := Network.Functions.cFunctions.c_readcacheindex(
                                                        Cache_ID);
      end readCacheIndex;

      function cacheNotEmpty

       annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
index = <b>ReadCacheIndex</b>(CacheID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function is the wrap function of C_Functions.c_readcacheindex in Modelica.
</p>





</html>"));
        input Integer Cache_ID;
      output Boolean NotEmpty;
      protected
      Integer index;
      algorithm
        index := Network.Functions.cFunctions.c_readcacheindex(
                                                        Cache_ID);
        if index>0 then
       NotEmpty:=true;
        else
       NotEmpty:=false;
        end if;
      end cacheNotEmpty;

      function enqueueHead

             annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
<b>EnqueueHead</b>(CacheID,Message_ID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function is the wrap function of cFunctions.c_enqueuehead in Modelica.
</p>


</html>"));
              input Integer Cache_ID;
            input Integer Message_ID;
      algorithm
              Network.Functions.cFunctions.c_enqueuehead(
                                              Cache_ID, Message_ID);

      end enqueueHead;

      function readCacheData
      annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Data= <b>ReadData_DataCache</b>(MessageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function parse the structured message defined in Network.Data_Structure.RcvData and return the <font color=\"#ff0000\">Real</font> format data.
The seperator between fields is \"\t\" (tab) .
</p>

<h3><font color=\"#008000\">Example</font></h3>
Data= ReadData_DataCache(1). <br>
Read the actual data from the message which has the ID 1.


</html>"));
        input Integer Message_ID "Message ID which to be parsed";

        output Real Data "Data extracted from the Message";

      protected
        String Message;
        Integer splitter[2];
        Integer endofinputstr;

      algorithm
        (Message) := Network.Functions.FrameFunctions.readMessage(
                                 Message_ID);
        endofinputstr := Modelica.Utilities.Strings.length(Message);

        splitter[1] := Modelica.Utilities.Strings.find(
                Message,
                "\t",
                1);
        splitter[2] := Modelica.Utilities.Strings.find(
                Message,
                "\t",
                splitter[1] + 1);

      Data := Modelica.Utilities.Strings.scanReal(
          Modelica.Utilities.Strings.substring(
                Message,
                splitter[2] + 1,
                endofinputstr));

      end readCacheData;
    end CacheFunctions;
  end Cache;

       package CAN
         model CANBasicNW

           annotation (Documentation(info=
                                        "<html>This Model represents the Medium of a CAN Network, i.e. the CAN Bus. All importent Properties of a CSMA/CR (Carrier
Sense Multiple Access/Collision Resolution) Network with bit-by-bit Arbitration are implemented in this Model.

<br><br> The Variable NumberofPorts_intern represents the Number of Nodes connected to the CAN Bus.
 </html>"),                                                                          Diagram);

           parameter Integer NumberofPorts_intern=4 "Number of connected ports";
           parameter Integer Transmissionrate_intern=125
        "Transmission rate (kbps)";

           Integer tryingnodes[NumberofPorts_intern];
           // if the nth node is trying to send, then tryingnode[n]=1 else =0;
           Interfaces.CANPort can_port[NumberofPorts_intern]
                                                 annotation (extent=[-8,-6; 6,8], style(
                pattern=3));                                                                                              //Internal ports to represent the CAN medium.

           Integer broadcastingMessage[NumberofPorts_intern];

           Integer activenode;     //The node which is now sending ;
           Integer highprioritynode; //Node with highest priority in Conflict Situation
           Integer Idents_inConflict[NumberofPorts_intern]; //Identifier of each message in Conflict State

           Boolean Portconnected[NumberofPorts_intern];   // state variable to indicate the connection status of the connector.

           // The public variable Bus_Busy is connected with  all connectors.
           Boolean Bus_Busy(start=false);
           Boolean Incomming_Frame[NumberofPorts_intern];     // Indicates which node receive the comming message flag.
           Boolean Lost_Arbitration[NumberofPorts_intern];  //Indicates which Node has lost Arbitration because of a higher priority message
           Boolean Successful_Transmission[NumberofPorts_intern]; //Indicates which Node has successfully transmitted its message

           Integer MessageInConflict[NumberofPorts_intern]; //Message ID's in Conflict
           Integer MessageInTransmission;  // The identifier of the message in transmission
           Real Transmissionduration "transmission duration for each packet";
           Real IdleTime_BetweenFrames;

           //protected
           Integer Sumoftryingnodes; // how many nodes are trying to send at the same time point
           Modelica.SIunits.Time transmittingbegin; //  begin time of a transmission
           Modelica.SIunits.Time transmissionend; // the time point of a successful transmission

           ////

           ///
         equation

           //Initialization:  scan all connected ports, if not connected, assign constant values to the port.
           when initial() then
             for i in 1:NumberofPorts_intern loop
                 if cardinality(can_port[i]) == 0 then
                   can_port[i].CacheBusConnector.sendCacheID = -1;
                   can_port[i].CacheBusConnector.rcvCacheID = -1;
                   can_port[i].Transmitt_trying = false;

                   Portconnected[i] = false;
                 else
                   Portconnected[i] = true;
                    end if;
             end for;
           end when;

           // The values of public variables are assigned to EVERY connector in every simulation step, except Conflict_MA and Successful_Tansmission.
           for  i in 1:NumberofPorts_intern loop
            can_port[i].Medium_Busy = pre(Bus_Busy);
            can_port[i].Conflict_MA = pre(Lost_Arbitration[i]);
            can_port[i].Successful_Transmission = pre(Successful_Transmission[i]);
            can_port[i].Incomming_Frame = pre(Incomming_Frame[i]); // flag of incomming message for each port,each node except sending node receives message.
           end for;

           //Setting IdleTime_BetweenFrames to 5 Bit Times -> depends on Transmissionrate_intern

           IdleTime_BetweenFrames=5/(Transmissionrate_intern*1000);

         algorithm

           if time>0 then   // since all the information exchange is based on the cache model, cache will be set up after time 0 so all the operation is taken place after time 0
               //Initial, waiting for triggering, if any node is trying to send, register the node in the array tryingnodes[]
             for
                i in 1:NumberofPorts_intern loop
              if Portconnected[i] == true then  //only check the connected ports
                // Incomming_Frame[i]:= false;
                 when (can_port[i].Transmitt_trying) then
                   //when requested, register the node which is trying to send
                  tryingnodes[i] := 1;
                 end when;
              end if;
             end for;

              Sumoftryingnodes:=sum(tryingnodes);
             //Got the sum of tryingnodes[]

             // No Node is trying to send
             //when Sumoftryingnodes == 0 then

             //end when;

             //more than one node is trying to send , conflict state set, Arbitration.
             when (Sumoftryingnodes) > 1 then
              //if more than one nodes are trying to send, only the message with the highest priority (lowest CAN_Identifier) is sent
              //  other nodes that failed sending its message, get the Lost_Arbitration state
              // in CAN, Transmission begins here
              Bus_Busy := true;
              transmittingbegin:=time;

              for i in 1:NumberofPorts_intern loop

                 if tryingnodes[i]==1 then

                 MessageInConflict[i]:=Network.Cache.CacheFunctions.dequeue(
                                                           can_port[i].CacheBusConnector.sendCacheID);

                 // Problem when two successive conflicts,i.e Idents_toSend is not reseted -> First highpriority node wins second conflict too!!!!!

                 Idents_inConflict[i]:=Network.CAN.CANFunctions.readIdentifier(MessageInConflict[i]);

                 end if;
             end for;

                 highprioritynode:=Network.CAN.CANFunctions.getHighpriorityNode(Idents_inConflict);
                 activenode:=highprioritynode;
                 MessageInTransmission:=MessageInConflict[activenode];
                 // calculate the Transmission Duration
                 Transmissionduration := Network.CAN.CANFunctions.readCANLength(
                                                          MessageInTransmission)*8/(Transmissionrate_intern*1000);
                  broadcastingMessage:=
                   Network.Functions.FrameFunctions.duplicateMessage(
                   MessageInTransmission, NumberofPorts_intern);

                 // The Node with the highest Priority is the Node with the lowest sent Identifier
                 // Other Nodes get the Conflict Flag Lost_Arbitration

              for i in 1:NumberofPorts_intern loop

                 //All nodes, who lost the arbitration, must try to get their Message through the next time the medium's free again
                 // Therefore all messages from these nodes have to be put back in their Send Cache!

                 if tryingnodes[i]==1 and i <> highprioritynode then

                   Lost_Arbitration[i]:=true;
                   Network.Cache.CacheFunctions.enqueueHead(
                                       can_port[i].CacheBusConnector.sendCacheID, MessageInConflict[i]);
                 else
                   Lost_Arbitration[i]:=false;
                 end if;

              end for;

             end when;

             // only one node is trying to send
             when (Sumoftryingnodes) == 1 then

              Bus_Busy := true;

              transmittingbegin:=time;
               for
                i in 1:NumberofPorts_intern loop

                 //find the active node which is trying to send
                  if tryingnodes[i] == 1 then
                    highprioritynode := i;
                    activenode:=highprioritynode;

                  end if;
               end for;

                 MessageInTransmission:=Network.Cache.CacheFunctions.dequeue(
                                                            can_port[activenode].CacheBusConnector.sendCacheID);

                 Transmissionduration := Network.CAN.CANFunctions.readCANLength(
                                                          MessageInTransmission)*8/(Transmissionrate_intern*1000);

                 broadcastingMessage:=
                   Network.Functions.FrameFunctions.duplicateMessage(
                   MessageInTransmission, NumberofPorts_intern);

             end when;

             // inform all nodes and recover from succesful transmission

           if  (transmittingbegin)>0 then
                when time > (transmittingbegin+Transmissionduration) then

                 transmissionend:=time;

                for i in 1:NumberofPorts_intern loop

                     // Enqueue high priority Message to all other nodes
                     if i <> activenode then
                     Network.Cache.CacheFunctions.enqueue(
                                        can_port[i].CacheBusConnector.rcvCacheID, broadcastingMessage[i]);
                       //!!!! Problem when enqueueing in 2 or more Nodes -> Enqueue Function deletes the Message after first enqueue
                       // -> Message for second node doesn't exist anymore --> Solution: new Function "duplicateMessage" copies each message
                      Incomming_Frame[i]:= true;
                      Lost_Arbitration[i]:=false;
                     else
                      Incomming_Frame[i]:=false;
                     end if;
                end for;

                  Bus_Busy:=false;
                  tryingnodes := zeros(NumberofPorts_intern);
                  Successful_Transmission[activenode]:= true;

                 // Expression Bus_Busy:=false here causes Simulation Error!! ????

                end when;
               end if;

             // Reset variables after a successful transmission

             if pre(transmissionend) > 0 then

               when time > (transmissionend + IdleTime_BetweenFrames) then

                // highprioritynode:=0;
                // activenode:=highprioritynode;

                 for i in 1:NumberofPorts_intern loop
                     // Idents must be reseted for correct behavior of CAN Network -> otherwise the Node with lowest Indentifier in Network holds its
                     // Highpriority State for all other Conflicts, regardless this Node is involved in Conflict or not !!!
                     Idents_inConflict[i]:=0;
                     Incomming_Frame[i]:= false;
                     Successful_Transmission[i]:=false;
                 end for;

               end when;

            end if;

           end if;
           //Graphical information

           annotation (Icon(
              Rectangle(extent=[-100,20; 100,-20], style(
                  color=0,
                  rgbcolor={0,0,0},
                   gradient=3,
                   fillColor=1,
                   rgbfillColor={125,125,125}), Text(
                 extent=[-30,70; 30,50],
                 style(
                   color=0,
                   rgbcolor={0,0,0},
                   gradient=3,
                   fillColor=1,
                   rgbfillColor={255,0,0}),
                 string="CAN Bus"))),
                          Diagram);
         equation

         end CANBasicNW;

         model CANTransceiverModul

           annotation (Documentation(info="<html>This is a primary Ethernet Modul which takes the charge of sensing the <br>
common medium and sending messange to following node.  </html>"),    Diagram,
               Icon(Rectangle(extent=[-68,54; 70,-44],   style(
                     color=0,
                     rgbcolor={0,0,0},
                     gradient=3,
                     fillColor=3,
                     rgbfillColor={0,0,255})), Text(
                   extent=[-52,24; 58,-26],
                   style(
                     color=0,
                     rgbcolor={0,0,0},
                     gradient=3,
                     fillColor=3,
                     rgbfillColor={0,0,255}),
                   string="%name")),
               DymolaStoredErrors);

           Interfaces.CANPort can_port
                                     annotation (extent=[66,-20; 106,20]);

           Interfaces.ICConnector messagequeue_connector
             annotation (extent=[-120,-18; -44,32], rotation=270);

           // Array with the Identifers, the Node is interested in

           inner parameter Integer CAN_Idents_toRcv[:];
           inner parameter Integer CAN_Ident_toSend;

    public
             Cache.Cache DataSendCache annotation (extent=[-46,22; -6,42]);
             Cache.Cache DataRcvCache annotation (extent=[-46,-4; -6,16]);
             Cache.Cache FrameSendCache annotation (extent=[6,22; 46,42]);
             Cache.Cache FrameRcvCache annotation (extent=[6,-4; 46,16]);
             Network.CAN.FrameModel.EncapsulateCAN encapsulate
               annotation (extent=[-12,16; 8,36]);
             Network.CAN.FrameModel.DecapsulateCAN decapsulate
               annotation (extent=[-12,12; 8,-8], rotation=180);
             Cache.CacheBUS cacheBUS annotation (extent=[44,8; 64,28], rotation=180);
             Cache.CacheBUS cacheBUS1 annotation (extent=[-44,4; -64,24], rotation=180);

         algorithm
           // sending when the medium is free and cache not empty
           if time>0 then
             if  not (can_port.Medium_Busy) and not (can_port.Incomming_Frame) then

                 if Network.Cache.CacheFunctions.readCacheIndex(
                                           FrameSendCache.cacheID) >= 1 then

                    can_port.Transmitt_trying:=true;

               end if;
             end if;

           // Reset after Succesful Transmission
           if (can_port.Successful_Transmission) then
               can_port.Transmitt_trying := false;
           end if;

           /* Lost_Arbitration State
-> Solution in CAN_BasicNW: Message is put back in appropriate FrameSendCache
here : Reset Transmitt_trying to trigger the when clause in CAN_BasicNW for tryingnodes (Line76)
*/
           if (can_port.Conflict_MA) then

              can_port.Transmitt_trying := false;

           end if;

           /*Prove, if received Message is interesting for this node
  -> this part is inserted into the Decapsulate_CAN Model
     Message is only enqueued to Task Side (DataRcvCache), if defined in CAN_Idents_toRcv[:]

*/
           end if;

         equation

             connect(DataSendCache.cacheConnector, encapsulate.SourceCache) annotation (
                 points=[-26.2,27.7; -17.1,27.7; -17.1,27.2; -7.2,27.2], style(color=3,
                   rgbcolor={0,0,255}));
             connect(encapsulate.DestinationCache, FrameSendCache.cacheConnector)
               annotation (points=[2.6,27.2; 14.3,27.2; 14.3,27.7; 25.8,27.7], style(color=
                    3, rgbcolor={0,0,255}));
             connect(DataRcvCache.cacheConnector, decapsulate.DestinationCache)
               annotation (points=[-26.2,1.7; -16.1,1.7; -16.1,1.4; -7,1.4], style(color=3,
                   rgbcolor={0,0,255}));
             connect(decapsulate.SourceCache, FrameRcvCache.cacheConnector) annotation (
                 points=[2.8,1.2; 14.4,1.2; 14.4,1.7; 25.8,1.7], style(color=3, rgbcolor={
                     0,0,255}));
             connect(FrameSendCache.cacheConnector, cacheBUS.sendCache) annotation (
                 points=[25.8,27.7; 39.9,27.7; 39.9,24.5; 53.6,24.5], style(color=3,
                   rgbcolor={0,0,255}));
             connect(FrameRcvCache.cacheConnector, cacheBUS.rcvCache) annotation (points=[25.8,1.7;
            39.9,1.7; 39.9,10.1; 54,10.1],                   style(color=3, rgbcolor={0,0,
                     255}));
             connect(messagequeue_connector.cacheBusConnector, cacheBUS1.cacheBusConnector)
               annotation (points=[-75.16,9; -64.58,9; -64.58,12.9; -62.3,12.9],   style(
                 color=74,
                 rgbcolor={0,0,127},
                 thickness=4));
             connect(cacheBUS1.sendCache, DataSendCache.cacheConnector) annotation (
                 points=[-53.6,20.5; -35.8,20.5; -35.8,27.7; -26.2,27.7], style(color=3,
                   rgbcolor={0,0,255}));
             connect(cacheBUS1.rcvCache, DataRcvCache.cacheConnector) annotation (points=[-54,6.1;
            -54,1.7; -26.2,1.7],                  style(color=3, rgbcolor={0,0,255}));
             connect(cacheBUS.cacheBusConnector, can_port.CacheBusConnector)
               annotation (points=[62.3,16.9; 76.15,16.9; 76.15,-16.4; 86.8,
            -16.4],                                                             style(
                 color=74,
                 rgbcolor={0,0,127},
                 thickness=4));

         end CANTransceiverModul;

         partial model CANBasicTask

           Integer Message_ID;
           Integer IncommingMessage;
           Integer i(start=1);

           Integer Intern_SendCache_ID;
           Integer Intern_RcvCache_ID;
           Integer RcvCacheIndex;

           Integer receivedIdent;
           Network.CAN.CANFrameType.Temp operation;
           Real data;

           Interfaces.ICConnector messagequeue_connector
             annotation (extent=[22,-30; 64,46], rotation=90);

    protected
            parameter String internKindofNode;
            parameter Integer internCAN_Ident_toSend;
            parameter Real internTransmitterperiod;
            parameter Real internTransmittbegin;
            parameter Integer internRequest_Ident;  // Ident for Remote Request -> Answer has the same Identifier and the appropiate Data
            parameter Real internRequestperiod;
            parameter Real internRequestbegin;

         equation
             Intern_SendCache_ID = messagequeue_connector.cacheBusConnector.sendCacheID;
             Intern_RcvCache_ID = messagequeue_connector.cacheBusConnector.rcvCacheID;
         algorithm
           ////////////////////////////////////////////////////////////

           if time>0 then
           //Send message
           //Because of the initial value change, it seems not possibel to handel more than one events at the beginning time point, suggestion: begin with 0.001 second.
           //Cyclic Sending the actual Data

           if internKindofNode=="CyclicSend" then
             when sample(internTransmittbegin, internTransmitterperiod) then

              Message_ID:=Network.CAN.CANFunctions.createCANMessage(
                   internCAN_Ident_toSend,Network.CAN.CANFrameType.CyclicFrame,
                   (i));
               i := i + 1;
               Network.Cache.CacheFunctions.enqueue(
                                       Intern_SendCache_ID,Message_ID);

             end when;
           end if;

           //Remtote Request Frame -> Requesting node sends no data, but requesting it

           if internKindofNode=="RemoteRequestOnly" then

               when sample( internRequestbegin,internRequestperiod) then

                 Message_ID:=Network.CAN.CANFunctions.createCANMessage(
                   internRequest_Ident,Network.CAN.CANFrameType.RemoteRequestFrame,
                   0);

               Network.Cache.CacheFunctions.enqueue(
                                       Intern_SendCache_ID,Message_ID);

               end when;

           end if;

           //////////////////////////////////////////////////////////////
           // Receiving message, when ReceiveCache changes -> Event based -> acyclic Receiving

            RcvCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(
                                                       Intern_RcvCache_ID);

             when change(RcvCacheIndex) then

               if Network.Cache.CacheFunctions.readCacheIndex(
                                     Intern_RcvCache_ID)>0 then
                 IncommingMessage := Network.Cache.CacheFunctions.dequeue(
                                             Intern_RcvCache_ID);

                 (receivedIdent,operation,data):=Network.CAN.CANFunctions.getCANMessage(IncommingMessage);

                 // Answer to RemoteRequest , Identifier Proved in DecapsulateCAN

                 if operation==Network.CAN.CANFrameType.RemoteRequestFrame then

                   Message_ID:=Network.CAN.CANFunctions.createCANMessage(
                   internCAN_Ident_toSend,Network.CAN.CANFrameType.AnswerRemoteRequest,
                   (i));
                   i := i + 1;
                   Network.Cache.CacheFunctions.enqueue(
                                       Intern_SendCache_ID,Message_ID);
                 end if;

               end if;

             end when;

           // Passive Part is not explicitely defined -> Node has only Receive Part from above

           end if;
           ////////////////////////////////////////////////////

           annotation (Diagram, Icon(Rectangle(extent=[-72,66; 60,-50], style(
                   color=0,
                   rgbcolor={0,0,0},
                   gradient=3,
                   fillColor=1,
                   rgbfillColor={255,0,0})), Text(
                 extent=[-60,38; 30,-16],
                 style(
                   color=0,
                   rgbcolor={0,0,0},
                   gradient=3,
                   fillColor=1,
                   rgbfillColor={255,0,0}),
                 string="%name")),
               DymolaStoredErrors);
         equation

         end CANBasicTask;

         model CANCylicNode

           annotation (Diagram, Icon(Rectangle(extent=[-72,66; 60,-50], style(
                   color=0,
                   rgbcolor={0,0,0},
                   gradient=3,
                   fillColor=1,
                   rgbfillColor={255,0,0})), Text(
                 extent=[-60,38; 30,-16],
                 style(
                   color=0,
                   rgbcolor={0,0,0},
                   gradient=3,
                   fillColor=1,
                   rgbfillColor={255,0,0}),
                 string="%name")),
               DymolaStoredErrors);

           parameter String KindofNode="CyclicSend";
           parameter Integer CAN_Ident_toSend;
           parameter Real Transmitterperiod;
           parameter Real Transmittbegin;

               extends Network.CAN.CANBasicTask(
                       internKindofNode=KindofNode, internCAN_Ident_toSend=CAN_Ident_toSend, internTransmitterperiod=Transmitterperiod,  internTransmittbegin=Transmittbegin);

         end CANCylicNode;

         model CANRemoteRequestNode

           annotation (Diagram, Icon(Rectangle(extent=[-72,66; 60,-50], style(
                   color=0,
                   rgbcolor={0,0,0},
                   gradient=3,
                   fillColor=1,
                   rgbfillColor={255,0,0})), Text(
                 extent=[-60,38; 30,-16],
                 style(
                   color=0,
                   rgbcolor={0,0,0},
                   gradient=3,
                   fillColor=1,
                   rgbfillColor={255,0,0}),
                 string="%name")),
               DymolaStoredErrors);

           parameter String KindofNode="RemoteRequestOnly";
           parameter Integer Request_Ident;
           parameter Real Requestperiod;
           parameter Real Requestbegin;
           parameter Integer CAN_Ident_toSend;

               extends Network.CAN.CANBasicTask(
                       internKindofNode=KindofNode, internRequest_Ident=Request_Ident, internRequestperiod=Requestperiod,  internRequestbegin=Requestbegin, internCAN_Ident_toSend=CAN_Ident_toSend);

         end CANRemoteRequestNode;

         model CANPassiveNode

           annotation (Diagram, Icon(Rectangle(extent=[-72,66; 60,-50], style(
                   color=0,
                   rgbcolor={0,0,0},
                   gradient=3,
                   fillColor=1,
                   rgbfillColor={255,0,0})), Text(
                 extent=[-60,38; 30,-16],
                 style(
                   color=0,
                   rgbcolor={0,0,0},
                   gradient=3,
                   fillColor=1,
                   rgbfillColor={255,0,0}),
                 string="%name")),
               DymolaStoredErrors);

           parameter String KindofNode="Passive";
           parameter Integer CAN_Ident_toSend;

               extends Network.CAN.CANBasicTask(
                       internKindofNode=KindofNode, internCAN_Ident_toSend=CAN_Ident_toSend);

         end CANPassiveNode;

         package FrameModel
             model DecapsulateCAN

               Cache.CacheConnector SourceCache
          "The Cache ID of the Frame Cache, which stores the Network Frame from network"
                                                                                                              annotation (extent=[-58,-18; -38,2]);
               Cache.CacheConnector DestinationCache
          "The Cache ID of the Data Cache, which stores the Raw data extracted from network frame"
                                                                                                              annotation (extent=[40,-16; 60,4]);
               annotation (Documentation( info="<html>Decapsulate the network frame to a raw data format defined in  <a href=\"Modelica://Network.Data_Structure.RcvData\"  ><font color=\"#ff0000\"> Network.Data_Structure.RcvData</font></a>. </html>"),                                                                                                    Diagram, Icon(
                   Text(
                     extent=[-76,-12; -40,-52],
                     style(
                       color=3,
                       rgbcolor={0,0,255},
                       gradient=3),
                     string="S"),
                   Text(
                     extent=[46,-12; 82,-52],
                     style(
                       color=3,
                       rgbcolor={0,0,255},
                       gradient=3),
                     string="D"),
                   Rectangle(extent=[-40,32; 42,-50], style(
                       color=42,
                       rgbcolor={127,0,0},
                       gradient=1,
                       fillColor=68,
                       rgbfillColor={170,213,255})),
                   Text(
                     extent=[-62,86; 66,24],
                     string="%name",
                     style(
                       color=0,
                       rgbcolor={0,0,0},
                       gradient=1,
                       fillColor=68,
                       rgbfillColor={170,213,255})),
                   Line(points=[-66,-80; 64,-80], style(
                       color=74,
                       rgbcolor={0,0,127},
                       thickness=4,
                       gradient=1,
                       arrow=1,
                       fillColor=42,
                       rgbfillColor={127,0,0}))),
                 DymolaStoredErrors);
             Integer SourceCacheIndex;
             Integer DestinationCacheIndex;
             Integer Message_toProve;
             Integer Ident_toProve;
             Integer Operation_toProve;
             Integer MessageInProcessing;
             Boolean Identifier_matched;

             outer Integer CAN_Idents_toRcv[:];  //Array of interesting Identifiers, that's defined in Transceiver Modul
             outer Integer CAN_Ident_toSend;     //Interesting Identifier for RemoteRequest Frame
             Integer Ignored_Message;

             algorithm
             if time>0 then
                 SourceCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(
                                                          SourceCache.cacheID);
                 DestinationCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(
                                                                   DestinationCache.cacheID);

             // Only enqueue in DestinationCache(Task Side), if Message is interesting for the Node,
             // i.e. Identifier of the Message to prove is definded in CAN_Idents_toRcv(Identifier matched -> true) or
             // the message is a Remote Request and the Node is able to provide the requested data (Ident_toProve==CAN_Ident_toSend)

               when change(SourceCacheIndex) then

                 Message_toProve:=Network.Cache.CacheFunctions.dequeue(
                                                              SourceCache.cacheID);
                 Ident_toProve:=Network.CAN.CANFunctions.readIdentifier(Message_toProve);

                 Operation_toProve:=Network.CAN.CANFunctions.readOperationType(Message_toProve);

                 Identifier_matched:=Network.CAN.CANFunctions.proveIdentifier(
                                                                          Ident_toProve,CAN_Idents_toRcv);

             // Ignore Message, if its Identifier is not matched and Node cannot provide requested Data

                 if Identifier_matched and Operation_toProve <>Network.CAN.CANFrameType.RemoteRequestFrame then

                       MessageInProcessing:=Network.CommonComponents.TransceiverFunctions.decapsulateFrameCAN(
                                                                       Message_toProve);
                       Network.Cache.CacheFunctions.enqueue(
                                         DestinationCache.cacheID, MessageInProcessing);

                 elseif (Ident_toProve==CAN_Ident_toSend) and (Operation_toProve ==Network.CAN.CANFrameType.RemoteRequestFrame) then

                       MessageInProcessing:=Network.CommonComponents.TransceiverFunctions.decapsulateFrameCAN(
                                                                       Message_toProve);
                       Network.Cache.CacheFunctions.enqueue(
                                         DestinationCache.cacheID, MessageInProcessing);
                 else

                    Ignored_Message:=Message_toProve;

                 end if;
              end when;

             end if;

             end DecapsulateCAN;

             model EncapsulateCAN

              Cache.CacheConnector SourceCache
          "The Cache ID of the Data Cache, which stores the Raw data from controller"
                                                                                                              annotation (extent=[-62,2; -42,22]);
               Cache.CacheConnector DestinationCache
          "The Cache ID of the Frame Cache, which stores the encapsulated Frame to be transmitted "
                                                                                                              annotation (extent=[36,2; 56,22]);
               annotation (Documentation( info="<html> Encapsulate the raw data with header information according to transmissino protocols. </html>"),Diagram, Icon(
                   Text(
                     extent=[-90,10; -48,-28],
                     style(
                       color=3,
                       rgbcolor={0,0,255},
                       gradient=3),
                     string="S"),
                   Text(
                     extent=[40,8; 82,-30],
                     style(
                       color=3,
                       rgbcolor={0,0,255},
                       gradient=3),
                     string="D"),
                   Rectangle(extent=[-44,48; 38,-34], style(
                       color=42,
                       rgbcolor={127,0,0},
                       gradient=1,
                       fillColor=42,
                       rgbfillColor={127,0,0})),
                   Text(
                     extent=[-66,96; 60,42],
                     string="%name",
                     style(
                       color=0,
                       rgbcolor={0,0,0},
                       thickness=4,
                       gradient=1,
                       fillColor=42,
                       rgbfillColor={127,0,0})),
                   Line(points=[-56,-72; 64,-72], style(
                       color=74,
                       rgbcolor={0,0,127},
                       thickness=4,
                       gradient=1,
                       arrow=1,
                       fillColor=42,
                       rgbfillColor={127,0,0}))));
             Integer SourceCacheIndex;
             Integer DestinationCacheIndex;
             Integer MessageInProcessing;

             algorithm
             if time>0 then
             SourceCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(
                                                        SourceCache.cacheID);
             DestinationCacheIndex:=Network.Cache.CacheFunctions.readCacheIndex(
                                                             DestinationCache.cacheID);

             when change(SourceCacheIndex) then
                 MessageInProcessing:=Network.Cache.CacheFunctions.dequeue(
                                                        SourceCache.cacheID);
                 MessageInProcessing:= Network.CommonComponents.TransceiverFunctions.encapsulateFrameCAN(MessageInProcessing);
                 Network.Cache.CacheFunctions.enqueue(
                                   DestinationCache.cacheID, MessageInProcessing);
             end when;
             end if;

             end EncapsulateCAN;
         end FrameModel;

         package CANFunctions
             function readIdentifier

             annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Identifier = <b>ReadIdentifier</b>(Message_ID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function returns the \"CAN_Ident \" field in <font color=\"#ff0000\">Integer</font> of the message in form of <a href=\"Modelica://Network.Data_Structure.CAN_Frame\"  ><font color=\"#ff0000\">Network.Data_Structure.CAN_Frame</font></a>.


</p>
</html>"));
               input Integer Message_ID;
               output Integer CAN_Ident;

      protected
               String Message;
               Integer splitter;

             algorithm
               (Message) := Network.Functions.FrameFunctions.readMessage(
                                        Message_ID);

               splitter := Modelica.Utilities.Strings.find(
                       Message,
                       "\t",
                       1);

               CAN_Ident := Modelica.Utilities.Strings.scanInteger(
                 Modelica.Utilities.Strings.substring(
                       Message,
                       1,
                       splitter-1));

             end readIdentifier;

             function readCANLength

             annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Length = <b>ReadCANLength</b>(Message_ID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function returns the \"Length \" field in <font color=\"#ff0000\">Integer</font> of the message in form of <a href=\"Modelica://Network.Data_Structure.CAN_Frame\"  ><font color=\"#ff0000\">Network.Data_Structure.CAN_Frame</font></a>.


</p>
</html>"));

               input Integer Message_ID;

               output Integer Length;

      protected
               String Message;
               Integer splitter[3];
               Integer endofinputstr;

             algorithm
               (Message) := Network.Functions.FrameFunctions.readMessage(
                                        Message_ID);
               endofinputstr := Modelica.Utilities.Strings.length(Message);

               splitter[1] := Modelica.Utilities.Strings.find(
                       Message,
                       "\t",
                       1);
               splitter[2] := Modelica.Utilities.Strings.find(
                       Message,
                       "\t",
                       splitter[1] + 1);
               splitter[3] := Modelica.Utilities.Strings.find(
                       Message,
                       "\t",
                       splitter[2] + 1);

             Length := Modelica.Utilities.Strings.scanInteger(
                 Modelica.Utilities.Strings.substring(
                       Message,
                       splitter[3] + 1,
                     endofinputstr));

             end readCANLength;

             function getHighpriorityNode

             input Integer idents[:];

             output Integer highidentnode;

      protected
             Integer highidentsofar;
             Integer highnodesofar;

             algorithm
             for i in 1:size(idents,1) loop

               if highidentsofar==0 and idents[i]<>0 then
                 highidentsofar:=idents[i];
                 highnodesofar:=i;

               elseif idents[i] <> 0 and idents[i] < highidentsofar then

                   highidentsofar:=idents[i];
                   highnodesofar:=i;

               end if;

             end for;

             highidentnode:=highnodesofar;

             end getHighpriorityNode;

             function proveIdentifier

             input Integer Ident_toProve;
             input Integer Idents_toMatch[:];

             output Boolean matched;

             algorithm
               for i in 1:size(Idents_toMatch,1) loop

                  if (Ident_toProve == Idents_toMatch[i]) then
                    matched:=true;
                  end if;

               end for;

             end proveIdentifier;

             function createCANMessage

              annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Message_ID = <b>CreateCANMessage</b>(DestinationAddress,Operation,Data);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function is the wrap function of c_createMessage in Modelica. It follows the data structure definition in  Network.Data_Structure.SendData
and combile the informations into a single string with \"\t\" (tab) seperator between fields. Return value is the identifier of the string.
</p>

<h3><font color=\"#008000\">Example</font></h3>
The typical application of this function can be found in Transceiver_Task. <br>



</html>"),       DymolaStoredErrors);

               input Integer CAN_Ident
          "indicates content and priority of the Message";
               input Network.CAN.CANFrameType.Temp Operation
          "Operation code to indicate the CAN message type, e.g. C for Cyclic, RR for Remote Request,ARR for Answer to RR and E for Error Frame";
               input Real Data "Actual data";

               output Integer Message_ID "Physic memory address of the message";
      protected
               output String inputstr;
             algorithm

              inputstr :=  String(CAN_Ident)
                  + "\t" + String(Operation) + "\t" + String(Data);
               Message_ID := Network.Functions.cFunctions.c_createmessage(
                                                    inputstr);

             end createCANMessage;

             function getCANMessage

             annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
(can_ident,operation,data)= <b>GetCANMessage</b>(messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function parse the structured message defined in Network.DataStructure.CANFrame and return three fields at once. Notice that the string format Data can not be directly used
in models, higher level functions are needed to parse the String format data into actual values.
The seperator between fields is \"\ t\" (tab) .
</p>

<h3><font color=\"#008000\">Example</font></h3>
(sourceAddress,operation, data)= getReceiveMessage(1). <br>
Read the actual message content from the message which has the ID 1.


</html>"));
               input Integer messageID "Message identifier which to be parsed";

               output Integer can_ident
          "From which network address comes the message";
               output Integer operation
          "Operation Type of CAN Frame, see Network.DataStructure.CAN_Frame";
               output Real data "Data extracted from the Message";

      protected
               String message;
               Integer splitter[2];
               Integer endofinputstr;

             algorithm
               (message) := Network.Functions.FrameFunctions.readMessage(
                                        messageID);
               endofinputstr := Modelica.Utilities.Strings.length(message);

               splitter[1] := Modelica.Utilities.Strings.find(
                       message,
                       "\t",
                       1);
               splitter[2] := Modelica.Utilities.Strings.find(
                       message,
                       "\t",
                       splitter[1] + 1);

               can_ident :=   Modelica.Utilities.Strings.scanInteger(Modelica.Utilities.Strings.substring(message,1,splitter[1]-1));
               operation :=  Modelica.Utilities.Strings.scanInteger(Modelica.Utilities.Strings.substring(message,splitter[1]+1,splitter[2]-1));
               data := Modelica.Utilities.Strings.scanReal(
                        Modelica.Utilities.Strings.substring(
                       message,
                       splitter[2] + 1,
                       endofinputstr));
             end getCANMessage;

             function readOperationType

             annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
(can_ident,operation,data)= <b>GetCANMessage</b>(messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function parse the structured message defined in Network.DataStructure.CANFrame and return three fields at once. Notice that the string format Data can not be directly used
in models, higher level functions are needed to parse the String format data into actual values.
The seperator between fields is \"\ t\" (tab) .
</p>

<h3><font color=\"#008000\">Example</font></h3>
(sourceAddress,operation, data)= getReceiveMessage(1). <br>
Read the actual message content from the message which has the ID 1.


</html>"));
               input Integer messageID "Message identifier which to be parsed";

               output Integer operation
          "Operation Type of CAN Frame, see Network.DataStructure.CAN_Frame";

      protected
               String message;
               Integer splitter[2];
               Integer endofinputstr;

             algorithm
               (message) := Network.Functions.FrameFunctions.readMessage(
                                        messageID);

               splitter[1] := Modelica.Utilities.Strings.find(
                       message,
                       "\t",
                       1);
               splitter[2] := Modelica.Utilities.Strings.find(
                       message,
                       "\t",
                       splitter[1] + 1);

               operation :=  Modelica.Utilities.Strings.scanInteger(
                             Modelica.Utilities.Strings.substring(message,splitter[1]+1,splitter[2]-1));

             end readOperationType;
         end CANFunctions;

         package CANFrameType
            extends Modelica.Icons.Enumeration;
             constant Integer CyclicFrame=1
        "Cylic Sending of Frames without Request";
             constant Integer RemoteRequestFrame=2
        "Node calls on a Node to send the requested Data ";
             constant Integer AnswerRemoteRequest=3
        "Node that can provide the requested Data sends it";

             type Temp

               extends Modelica.Icons.TypeInteger;
             end Temp;
         end CANFrameType;
       end CAN;

  package PrimaryController

    partial model BasePrimaryController
        annotation(Documentation(info="<html>Primary controller is an abstracted controller model which consists of only network transmission task. It simply sends and receives network messages cyclically. It is used to demonstrate the functionality of Transceivermodul. </html>"));
          Network.Interfaces.ICConnector iCConnector
            annotation (extent=[38,-24; 110,52], rotation=90);

          annotation (Icon(
                 Rectangle(extent=[-70,74; 74,-42], style(
                  color=0,
                  rgbcolor={0,0,0},
                  fillColor=74,
                  rgbfillColor={0,0,127}))));
        Integer messageID;
        Integer incommingMessage;
        Integer i(start=1);

        parameter Integer destinationAddress;
        parameter Real transmittPeriod=1;
        parameter Real transmittBegin=0.001;

        parameter Real receivePeriod=0.1;
        parameter Real receiveBegin=0.1;
        Integer messageLength(start=64);
        Integer internSendCacheID;
        Integer internRcvCacheID;
        Integer SourceAddress;
        Network.OperationType.Temp operation;
        Real data;

    equation
          internSendCacheID =iCConnector.cacheBusConnector.sendCacheID;
          internRcvCacheID = iCConnector.cacheBusConnector.rcvCacheID;
    algorithm

        ////////////////////////////////////////////////////////////
        //Send message
        //Because of the initial value change, it seems not possibel to handel more than one events at the beginning time point, suggestion: begin with 0.001 second.
          when sample(transmittBegin, transmittPeriod) then

          messageID:=Network.PrimaryController.ProtocolFunctions.SingleValueDataProtocol.createSendMessage(
                                                                                  destinationAddress,Network.OperationType.ReadSensorValue, (i));
          i := i + 1;
          Network.Cache.CacheFunctions.enqueue(     internSendCacheID,messageID);
          messageLength:=pre(messageLength);
          end when;

        //////////////////////////////////////////////////////////////

        //Read the message from ethernet modul

          when sample(receiveBegin, receivePeriod) then
            if Network.Cache.CacheFunctions.cacheNotEmpty(     internRcvCacheID) then
              incommingMessage := Network.Cache.CacheFunctions.dequeue(     internRcvCacheID);
              (SourceAddress,operation,data) := Network.PrimaryController.ProtocolFunctions.SingleValueDataProtocol.getReceiveMessage(
                                                                                  incommingMessage);
            end if;
          end when;
    end BasePrimaryController;

    package ProtocolFunctions
      model Description

      annotation (DocumentationClass=true, Documentation(info="<html>
The functions in Network.PrimaryController.ProtocolFunctions are modelica functions which concern making and parsing message in controller core.
<p>Basis functions are  <a href =Modelica://Network.PrimaryController.ProtocolFunctions.CreateSendMessage>Network.PrimaryController.ProtocolFunctions.CreateSendMessage</a>
and  <a href = Modelica://Network.PrimaryController.ProtocolFunctions.GetReceiveMessage>Network.PrimaryController.ProtocolFunctions.GetReceiveMessage</a>. In these two functions, Data field is defined
as String, thus arbitrary information can be composed. </p>
<p>For specific use, users of the library are suggested to define own functions based on these two functions. Design patterns are illustrated in
<a href=Modelica://Network.PrimaryController.ProtocolFunctions.SingleValueDataProtocol>Network.PrimaryController.ProtocolFunctions.SingleValueDataProtocol</a> and
<a href=Modelica://Network.PrimaryController.ProtocolFunctions.ArrayValueDataProtoco>Network.PrimaryController.ProtocolFunctions.ArrayValueDataProtocol</a> </p>

 </html>"));

      end Description;

    package SingleValueDataProtocol
    annotation (Documentation(preferedView="info",info="<html>These two functions are high level functions based on general
<a href=Modelica://Network.PrimaryController.ProtocolFunctions.CreateSendMessage>Network.PrimaryController.ProtocolFunctions.CreateSendMessage</a>, and
<a href=Modelica://Network.PrimaryController.ProtocolFunctions.GetReceiveMessage>Network.PrimaryController.ProtocolFunctions.GetReceiveMessage</a>.
They defines explicitly that the data field is a single value Real variable.
</html>"));
      function createSendMessage
      annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
messageID = <b>createSendMessage</b>(destinationAddress,operation,data);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function is the wrap function of <a href=Modelica://Network.PrimaryController.ProtocolFunctions.createSendMessage>Network.PrimaryController.ProtocolFunctions.createSendMessage</a>.
It follows the data structure definition in  Network.DataStructure.SendMessage
and combile the informations into a single string with \" \ t \" (tab) seperator between fields.
The Data field is defined explicitly as a single Real value.
 Return value is the identifier of the string.
</p>

<h3><font color=\"#008000\">Example</font></h3>
The typical application of this function can be found in BasePrimaryController. <br>



</html>"));

        input Integer destinationAddress "Address of the destination node";
        input Network.OperationType.Temp operation
            "Operation code to indicate the message type, see Network.Enumeration ";
        input Real data "Actual data";
        output Integer messageID "Unique identifer of the message";
      algorithm

          messageID :=
            Network.PrimaryController.ProtocolFunctions.createSendMessage(
                  destinationAddress,
                  operation,
                  String(data));

      end createSendMessage;

      function getReceiveMessage
      annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
(sourceAddress,operation,data)= <b>getReceiveMessage</b>(messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function is a wrap function of <a href= Modelica://Network.PrimaryController.ProtocolFunctions.getReceiveMessage>Network.PrimaryController.ProtocolFunctions.getReceiveMessage</a>.
Data field is defined as a single Real value here.

</p>

<h3><font color=\"#008000\">Example</font></h3>
(sourceAddress,operation, data)= getReceiveMessage(1). <br>
Read the actual message content from the message which has the ID 1.


</html>"));
        input Integer messageID;
        output Integer sourceAddress;
        output Network.OperationType.Temp operation;
        output Real data "Data extracted from the Message";
        protected
        String dataString;
      algorithm
          (sourceAddress,operation,dataString) :=
            Network.PrimaryController.ProtocolFunctions.getReceiveMessage(
            messageID);

        data:=Modelica.Utilities.Strings.scanReal(dataString);
      end getReceiveMessage;
    end SingleValueDataProtocol;

      package ArrayValueDataProtocol
        "Package that contains functions that handle the network packet protocol issues"
        annotation (Documentation(preferedView="info",info="<html>These two functions are high level functions based on general
<a href=Modelica://Network.PrimaryController.ProtocolFunctions.CreateSendMessage>Network.PrimaryController.ProtocolFunctions.CreateSendMessage</a>, and
<a href=Modelica://Network.PrimaryController.ProtocolFunctions.GetReceiveMessage>Network.PrimaryController.ProtocolFunctions.GetReceiveMessage</a>.

They defines explicitly that the data field is an array of Real variables.
</html>"));
        function createSendMessage
        annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
Message_ID = <b>CreateSendMessage</b>(DestinationAddress,Operation,valueArray[:]);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function is the wrap function of <a href=Modelica://Network.PrimaryController.ProtocolFunctions.createSendMessage>Network.PrimaryController.ProtocolFunctions.createSendMessage</a>.
It follows the data structure definition in  Network.DataStructure.SendMessage
and combile the informations into a single string with \" \ t \" (tab) seperator between fields.
The Data field is defined explicitly as an array of Real variables.
 Return value is the identifier of the string.
</p>

<h3><font color=\"#008000\">Example</font></h3>
The typical application of this function can be found in BasePrimaryController. <br>



</html>"));

          input Integer destination "The destination network address";
          input Network.OperationType.Temp operation
            "The operation, see  Network.Operation_Type";
          input Real valueArray[:] "The array with the values.";
          output Integer messageID "The ID of the message";

        protected
          String message;
          Integer length;
        algorithm
          message:="";
          length:=size(valueArray,1);

          for i in 1:length loop
            if (i==1) then
              message:=message + String(valueArray[i]);
            else
              message:=message + "," + String(valueArray[i]);
            end if;
          end for;

          messageID :=
            Network.PrimaryController.ProtocolFunctions.createSendMessage(
                    destination,
                    operation,
                    message);

        end createSendMessage;

        function getReceiveMessage
          annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
(sourceAddress,operation,valueArray[])= <b>getReceiveMessage</b>(MessageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function is a wrap function of <a href= Modelica://Network.PrimaryController.ProtocolFunctions.getReceiveMessage>Network.PrimaryController.ProtocolFunctions.getReceiveMessage</a>.
The Data field is defined explicitly as an array of Real variables.

</p>

<h3><font color=\"#008000\">Example</font></h3>
(sourceAddress,operation, valueArray[])= getReceiveMessage(1). <br>
Read the actual message content from the message which has the ID 1.


</html>"));
          import Modelica.Utilities.Strings.*;

          input Integer messageID "The ID of the message.";
          input Integer arraySize=6 "The desired size of the valueArray";
          output Integer sourceAddress;
          output Network.OperationType.Temp operation;
          output Real valueArray[arraySize] "The array with the values.";

        protected
          String data;
          String realString;
          Integer startIndex;
          Integer index;
          Integer messageLength;
          Integer valueIndex;
        algorithm

          Modelica.Utilities.Streams.print("ArrayProtocolFunctions.GetReceiveMessage.messageID: "+String(messageID));
          (sourceAddress,operation,data) := Network.PrimaryController.ProtocolFunctions.getReceiveMessage(messageID);

          Modelica.Utilities.Streams.print("ArrayProtocolFunctions.GetReceiveMessage: "+data);
          messageLength := length(data);

          startIndex:=1;
          valueIndex:=1;

          index:=find(data, ",",startIndex);

          while
               (index<>0) loop
            realString:=substring(data,startIndex,index-1);
            valueArray[valueIndex]:=scanReal(realString);
            valueIndex:=valueIndex + 1;

            startIndex:=index + 1;
            index:=find(
              data,
              ",",
              startIndex);
          end while;

          if (startIndex<=messageLength) then
            realString:=substring(data,startIndex,messageLength);
            valueArray[valueIndex]:=scanReal(realString);
            valueIndex:=valueIndex+1;
          end if;

          for i in valueIndex:arraySize loop
            valueArray[i]:=0;
          end for;

        end getReceiveMessage;
      end ArrayValueDataProtocol;

      function createSendMessage
      annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
messageID = <b>createSendMessage</b>(destinationAddress,operation,data);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function is the wrap function of c_createMessage in Modelica. It follows the data structure definition in  Network.DataStructure.SendMessage
and combile the informations into a single string with \" \ t \" (tab) seperator between fields. Return value is the identifier of the string.
</p>

<h3><font color=\"#008000\">Example</font></h3>
The typical application of this function can be found in BasePrimaryController. <br>



</html>"));

        input Integer destinationAddress "Address of the destination node";
        input Network.OperationType.Temp operation
          "Operation code to indicate the message type, see Network.Operation_Type";
        input String data "Actual data";

        output Integer messageID "Unique identifier of the message";
      protected
        output String inputstr;
      algorithm

       inputstr :=  String(destinationAddress)
           + "\t" + String(operation) + "\t" + data;
       messageID := Network.Functions.cFunctions.c_createmessage( inputstr);

      end createSendMessage;

      function getReceiveMessage
      annotation (preferedView="info",Documentation(info="<html>
<h3><font color=\"#008000\">Syntax</font></h3>
<blockquote><pre>
(sourceAddress,operation,data)= <b>getReceiveMessage</b>(messageID);
</pre></blockquote>
<h3><font color=\"#008000\">Description</font></h3>
<p>
This function parse the structured message defined in Network.DataStructure.RcvMessage and return three fields at once. Notice that the string format Data can not be directly used
in models, higher level functions are needed to parse the String format data into actual values.
The seperator between fields is \"\ t\" (tab) .
</p>

<h3><font color=\"#008000\">Example</font></h3>
(sourceAddress,operation, data)= getReceiveMessage(1). <br>
Read the actual message content from the message which has the ID 1.


</html>"));
        input Integer messageID "Message identifier which to be parsed";

        output Integer sourceAddress
          "From which network address comes the message";
        output Network.OperationType.Temp operation
          "Operation type,see Network.Operation_Type";
        output String data "Data extracted from the Message";

      protected
        String message;
        Integer splitter[2];
        Integer endofinputstr;

      algorithm
        (message) := Network.Functions.FrameFunctions.readMessage(
                                 messageID);
        endofinputstr := Modelica.Utilities.Strings.length(message);

        splitter[1] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                1);
        splitter[2] := Modelica.Utilities.Strings.find(
                message,
                "\t",
                splitter[1] + 1);

        sourceAddress :=   Modelica.Utilities.Strings.scanInteger(Modelica.Utilities.Strings.substring(message,1,splitter[1]-1));
        operation := Modelica.Utilities.Strings.scanInteger(Modelica.Utilities.Strings.substring(message,splitter[1]+1,splitter[2]-1));
        data := Modelica.Utilities.Strings.substring(
                message,
                splitter[2] + 1,
                endofinputstr);

      end getReceiveMessage;
    end ProtocolFunctions;
  end PrimaryController;

  package OperationType
     extends Modelica.Icons.Enumeration;
    constant Integer ReadSensorValue=1 "Read value from sensors";
    constant Integer UpdateActuatorValue=2 "updata values to actuators";
    constant Integer Diagnose=3 "Diagnose";
    type Temp

      extends Modelica.Icons.TypeInteger;
    end Temp;
  end OperationType;
end Network;
