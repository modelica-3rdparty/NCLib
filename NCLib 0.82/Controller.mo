package Controller

  annotation(preferedView="info",Documentation(info="<html>
<h4>Author</h4>
<p>
  Florian Wagner<br>
  TU Kaiserslautern<br>
  FB EIT, JPA²<br>
  Erwin-Schrödinger-Str. 12<br>
  67663 Kaiserslautern<br>
  Germany<br>
  eMail: <a href=\"mailto:wagner@eit.uni-kl.de\">wagner@eit.uni-kl.de</a><br>
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
  annotation (uses(Modelica(version="2.2.2")));
  package UsersGuide "User's Guide"
    annotation (DocumentationClass=true, Documentation(info="<html>
<h3><font color=\"#008000\" size=5>User's Guide of the Controller Library</font></h3>
<p>
Package <b>Controller</b> hosts models that are related to embedded devices which are used in automation technology.
</p>
<p>A good starting point for using the library is the <a href=\"Controller.Examples\">Examples</a> package which contains various demonstrations on how to use the Controller library, also in combination with the <a href=\"Network\">Network</a> library.
</html>"));
  end UsersGuide;

  package Board "Package that contains models of embedded devices"
    annotation (
      preferedView="info",
      Coordsys(
        extent=[0, 0; 446, 493],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.05,
        y=0.09,
        width=0.44,
        height=0.71,
        library=1,
        autolayout=1),
      Documentation(info="
<HTML>
<p>
This package contains models which represent embedded devices (boards) with interfaces to the process under control and the network.
</p>
<h3>Archetype of an embedded controller</h3>
<p>The most general board model <a href=\"Controller.Board.NetworkIOBoard\">NetworkIOBoard</a> has the architecture as shown in Figure 1, and serves as archetype for all other board models which add or remove functionality.<br>
<br>
<img src=\"../doc/images/EmbeddedDeviceArchetype.png\" width=\"700\"><br>
<br>
<b>Figure 1: Archetype of an embedded controller</b><br>
<br>
The different line styles of connections describe different kinds of information exchanged between components as desribed in Table 1.<br>
<br>
<br>
<table border=\"1\">
  <tr><td>line style</td><td>type of information</td></tr>
  <tr><td>solid</td><td>physical values, process values</td></tr>
  <tr><td>dashed</td><td>network messages</td></tr>
  <tr><td>dotted</td><td>device internal messages, e.g. DA-Converted process values or content of network messages</td></tr>
</table>
</p>
<p>
<ul>
  <b>Process interface</b>
  <li>
    To get information from the real world (process) the <i>AD-converter</i> component is used.
    It can be either directly connected to process models or can receive information from sensor models, if sensor dynamics can not be neglected.
    AD-converter models (e.g. <a href=\"Controller.ProcessInterface.SampledADConverter\">SampledADConverter</a>) can be found in the <a href=\"Controller.ProcessInterface\">Controller.ProcessInterface</a> package.
  </li>
  <li>
    To send information to the real world (process) the <i>DA-converter</i> component is used.
    It can be either directly connected to process models or can send information to actuator models, if actuator dynamics can not be neglected.
    DA-converter models (e.g. <a href=\"Controller.ProcessInterface.SampledDAConverter\">SampledDAConverter</a>) can be found in the <a href=\"Controller.ProcessInterface\">Controller.ProcessInterface</a> package.
  </li>
  <li>
    The result of the AD-conversion is stored in a memory called <i>process image of inputs</i> (PIInputs), which is a random access memory (model <a href=\"Controller.Memory.RAM\">RAM</a>). The CPU can read information from this process image.
  </li>
  <li>
    The values to be published to the process are stored in the <i>process image of outputs</i> (PIOutputs), which is a random access memory (model <a href=\"Controller.Memory.RAM\">RAM</a>). The CPU can write information to this process image.
  </li>
  <br>
  <br>
  <b>Network interface</b>
  <li>
    To exchange information between embedded devices the <i>transceiver</i> component is used. The <i>transceiver</i> component hides the complexity of network interfacing from the developper.
    The <i>CPU</i> component can write messages to be sent via network to the <i>transceiver</i> and can read messages that have been received via network from the <i>transceiver</i>.
    The <i>transceiver</i> component is provided by the <a href=\"Network\">Network</a> library. There you can find more information on how to interface the <i>transceiver</i> component.
  </li>
  <br>
  <br>
  <b>Execution of programs</b>
  <li>
    The <i>CPU</i> component is used to execute the algorithms in the embedded device. The package <a href=\"Controller.CPU\">Controller.CPU</a> hosts the CPU models.
    The algorithms run in tasks inside the CPU. To exchange information between the tasks, the <i>RAM</i> component is used.
  </li>
  <li>
    To allow useful algorithms, the CPU model has access to the process images, the network interface and the RAM.
  </li>
</ul>
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>January 21, 2008</i>
       by <a href=\"http://www.eit.uni-kl.de/frey\">Florian Wagner</a>
</li>
</ul>
</html>"));
    model NetworkIOBoard
      "Model of an embedded device with interfaces to the process under control and the network"
      import Controller;
      extends Controller.Interfaces.INetworkIOBoard(redeclare replaceable
          Network.Interfaces.NetworkPort networkPort extends
          Network.Interfaces.NetworkPort);
      annotation (preferedView="info",Diagram,Documentation(info="
<HTML>
<p>
This model represents an embedded device with interfaces to the process under control and the network. It's the most general board model in the library.
</p>
<p>
In order to use it, the network connector and transceiver type have to be defined. For networks of type ZigBee, WLAN, and Ethernet, the library already provides adopted models (<a href=\"Controller.Board.ZigBeeNetworkIOBoard\">ZigBeeNetworkIOBoard</a>).
</p>
<p>
Information about the method of operation of the NetworkIOBoard take a look a the <a href=\"Controller.Board\">Board</a> package description.
</p>
</HTML>
",   revisions=
             "<html>
<ul>
<li><i>February 2nd, 2008</i>
       by <a href=\"http://www.eit.uni-kl.de/frey\">Florian Wagner</a>
</li>
</ul>
</html>"));

      replaceable CPU.CPUWithNetwork cPUWithNetwork(address=address) extends
        Controller.CPU.CPUWithNetwork(address=address)
        "the CPU model hosting the tasks"
        annotation (extent=[-20, -20; 20, 20], choicesAllMatching=true);
      replaceable Controller.ProcessInterface.SampledADConverter aDConverter(n=
            ni) extends Controller.Interfaces.IADConverter
        "u -> AD-Converter -> PIInputs"
        annotation (extent=[-98, -18; -60, 20], choicesAllMatching=true);
      Controller.Memory.RAM PIInputs "the process image of inputs (PIInputs)"
        annotation (extent=[-60, -20; -20, 20]);
      replaceable Controller.ProcessInterface.SampledDAConverter dAConverter(n=
            no) extends Controller.Interfaces.IDAConverter
        "the DA-Converter IC converting output set values from the process image of outputs (PIOutputs) to analog signals"
        annotation (extent=[60, -20; 100, 20], choicesAllMatching=true);
      Controller.Memory.RAM PIOutputs
        "the process image of ooutputs (PIOutputs)"
        annotation (extent=[20, -20; 60, 20]);
      replaceable Network.CommonComponents.CSMACAtransceivermodul transceiver
        annotation (extent=[40,-80; 80,-40]);
    equation

      connect(aDConverter.PIInputs, PIInputs.RAMIndex) annotation (points=[-63.8,1;
            -64,1; -64,-12; -40,-12; -40,-12],      style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4));
      connect(u, aDConverter.analogInputs) annotation (points=[-120, 0; -102, 0;
            -102, 1; -98, 1], style(
          color=74,
          rgbcolor={0,0,127},
          fillPattern=1));
      connect(PIOutputs.RAMIndex, dAConverter.PIOutputs) annotation (points=[40,-12;
            60,-12; 60,0],
                       style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4));
      connect(dAConverter.analogOutputs, y) annotation (points=[98, 0; 110, 0],
          style(
          color=74,
          rgbcolor={0,0,127},
          fillPattern=1));
      connect(PIInputs.RAMIndex, cPUWithNetwork.PIInputs) annotation (points=[-40,-12;
            -20,-12; -20,0],
                        style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4,
          fillPattern=1));
      connect(cPUWithNetwork.PIOutputs, PIOutputs.RAMIndex) annotation (points=[20,0; 20,
            -12; 40,-12],                     style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4,
          fillPattern=1));
      connect(transceiver.networkPort, networkPort) annotation (points=[70.4,
            -43.4; 92,-43.4; 92,-92; 32,-92; 32,-80; 0,-80], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=4));
      connect(transceiver.iCConnector, cPUWithNetwork.iCConnector)
        annotation (points=[50.4,-75.4; 18,-75.4; 18,-14], style(
          color=2,
          rgbcolor={0,255,0},
          thickness=4));
    end NetworkIOBoard;

    model IOBoard
      "Model of an embedded device with access to the process under control"
      import Controller;
      extends Controller.Interfaces.IIOBoard;

    annotation (Diagram,Documentation(info="
<HTML>
<p>
This model represents an embedded device with an interface to the process under control.
</p>
<p>
Information about the method of operation of the IOBoard take a look a the <a href=\"Controller.Board\">Board</a> package description.
</p>
</HTML>
",   revisions=
             "<html>
<ul>
<li><i>February 2nd, 2008</i>
       by <a href=\"http://www.eit.uni-kl.de/frey\">Florian Wagner</a>
</li>
</ul>
</html>"));

      replaceable CPU.CPU cPU extends Controller.CPU.CPU
        "the CPU model hosting the tasks"
        annotation (extent=[-10, -10; 10, 10], choicesAllMatching=true);
      annotation (Diagram);
      replaceable Controller.ProcessInterface.SampledADConverter aDConverter(n=
            ni) extends Controller.Interfaces.IADConverter
        "u -> AD-Converter -> PIInputs"
        annotation (extent=[-80, -10; -60, 10], choicesAllMatching=true);
      Controller.Memory.RAM PIInputs annotation (extent=[-52, -10; -32, 10]);
      replaceable Controller.ProcessInterface.SampledDAConverter dAConverter(n=
            no) extends Controller.Interfaces.IDAConverter
        "PIOutputs -> DAConverter -> y"
        annotation (extent=[70, -10; 90, 10], choicesAllMatching=true);
      Controller.Memory.RAM PIOutputs
        annotation (extent=[40, -10; 60, 10], choicesAllMatching=true);
    equation
      connect(aDConverter.PIInputs, PIInputs.RAMIndex) annotation (points=[-62,0;
            -62,12; -42,12; -42,-6],      style(pattern=0, thickness=4));
      connect(u, aDConverter.analogInputs) annotation (points=[-120, 0; -80, 0],
          style(
          color=74,
          rgbcolor={0,0,127},
          thickness=4,
          fillPattern=1));
      connect(PIInputs.RAMIndex, cPU.PIInputs) annotation (points=[-42,-6; -26,
            -6; -26,0; -10,0],
                style(
          pattern=0,
          thickness=4,
          fillPattern=1));
      connect(PIOutputs.RAMIndex, dAConverter.PIOutputs)
        annotation (points=[50,-6; 60,-6; 60,0; 70,0],
                                           style(pattern=0, thickness=4));
      connect(dAConverter.analogOutputs, y) annotation (points=[89, 0; 110, 0],
          style(
          color=74,
          rgbcolor={0,0,127},
          thickness=4,
          fillPattern=1));
      connect(cPU.PIOutputs, PIOutputs.RAMIndex) annotation (points=[10,0; 30,0;
            30,12; 50,12; 50,-6],      style(
          pattern=0,
          thickness=4,
          fillPattern=1));
    end IOBoard;

    model NetworkBoard
      "Model of an embedded device with an interface to the network"
      extends Interfaces.INetworkBoard;

    annotation (Diagram,Documentation(info="
<HTML>
<p>
This model represents an embedded device with an interfacethe network. It's the most general pure network board model in the library.
</p>
<p>
In order to use it, the network connector and transceiver type have to be defined. For networks of type ZigBee, WLAN, and Ethernet, the library already provides adopted models (<a href=\"Controller.Board.ZigBeeNetworkBoard\">ZigBeeNetworkBoard</a>).
</p>
<p>
Information about the method of operation of the NetworkBoard take a look a the <a href=\"Controller.Board\">Board</a> package description.
</p>
</HTML>
",   revisions=
             "<html>
<ul>
<li><i>February 2nd, 2008</i>
       by <a href=\"http://www.eit.uni-kl.de/frey\">Florian Wagner</a>
</li>
</ul>
</html>"));

      replaceable CPU.CPUWithNetwork cPUWithNetwork(address=address) extends
        CPU.CPUWithNetwork(address=address) "the CPU model hosting the tasks"
                                          annotation (extent=[-20, -20; 20, 20], choicesAllMatching=true);
      annotation (Diagram);

      replaceable Network.CommonComponents.CSMACAtransceivermodul transceiver
        annotation (extent=[40,-80; 80,-40]);
    equation
      connect(transceiver.iCConnector, cPUWithNetwork.iCConnector)
        annotation (points=[50.4,-75.4; 18,-75.4; 18,-14], style(color=2,
            rgbcolor={0,255,0}));
      connect(transceiver.networkPort, networkPort) annotation (points=[70.4,
            -43.4; 70.4,-34; 90,-34; 90,-86; 22,-86; 22,-80; 0,-80], style(
            color=3, rgbcolor={0,0,255}));
    end NetworkBoard;
    annotation (Icon(
        Rectangle(extent=[-20, 20; 20, -20], style(color=0, rgbcolor={0,0,0})),
        Rectangle(extent=[-80, -34; 80, -46], style(color=0, rgbcolor={0,0,0})),
        Rectangle(extent=[-100, 20; -60, -20], style(color=0, rgbcolor={0,0,0})),
        Rectangle(extent=[60, 20; 100, -20], style(color=0, rgbcolor={0,0,0})),
        Rectangle(extent=[60, -60; 100, -100], style(color=0, rgbcolor={0,0,0})),
        Line(points=[-70, -20; -70, -34], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[0, -20; 0, -34], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[70, -20; 70, -34], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[70, -46; 70, -60], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Rectangle(extent=[-100, 100; 100, 60], style(color=0, rgbcolor={0,0,0})),
        Line(points=[-80, 94; -80, 66], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[-60, 94; -60, 66], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[-20, 94; -20, 66], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[0, 94; 0, 66], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[20, 94; 20, 66], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[60, 94; 60, 66], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[80, 94; 80, 66], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1)),
        Line(points=[0, 20; 0, 60], style(
            color=0,
            rgbcolor={0,0,0},
            fillPattern=1))));

    model ZigBeeNetworkBoard
      "Model of an embedded device with interfaces to a ZigBee network"
      extends NetworkBoard(redeclare Network.ZigBee.ZigbeeTransceivermodul
          transceiver(sourceAddress=address),
                       redeclare Network.Interfaces.ZigBeePort networkPort);

      annotation (Diagram,Documentation(info="
<HTML>
<p>
This model represents an embedded device with an interface to a ZigBee network.
</p>
<p>
Information about the method of operation of the ZigBeeNetworkBoard take a look a the <a href=\"Controller.Board\">Board</a> package description.
</p>
</HTML>
",   revisions=
             "<html>
<ul>
<li><i>February 2nd, 2008</i>
       by <a href=\"http://www.eit.uni-kl.de/frey\">Florian Wagner</a>
</li>
</ul>
</html>"));

      annotation (Diagram);
    end ZigBeeNetworkBoard;

    model ZigBeeNetworkIOBoard
      "Model of an embedded device with an interface to the process under control and to a ZigBee network"
      extends NetworkIOBoard(redeclare Network.ZigBee.ZigbeeTransceivermodul
          transceiver(sourceAddress=address),
                       redeclare Network.Interfaces.ZigBeePort networkPort);
    annotation (Diagram,Documentation(info="
<HTML>
<p>
This model represents an embedded device with interfaces to the process under control and a ZigBee network.
</p>
<p>
Information about the method of operation of the ZigBeeNetworkIOBoard take a look a the <a href=\"Controller.Board\">Board</a> package description.
</p>
</HTML>
",   revisions=
             "<html>
<ul>
<li><i>February 2nd, 2008</i>
       by <a href=\"http://www.eit.uni-kl.de/frey\">Florian Wagner</a>
</li>
</ul>
</html>"));
    end ZigBeeNetworkIOBoard;

    model EthernetNetworkBoard
      extends NetworkBoard(redeclare Network.Ethernet.EthernetTransceiverModul
          transceiver(sourceAddress=address), redeclare
          Network.Interfaces.EthernetPort networkPort);
      annotation (Diagram);
    end EthernetNetworkBoard;

    model EthernetNetworkIOBoard
      extends NetworkIOBoard(redeclare
          Network.Ethernet.EthernetTransceiverModul transceiver( sourceAddress=
              address), redeclare Network.Interfaces.EthernetPort networkPort);
      annotation (Diagram);
    end EthernetNetworkIOBoard;
  end Board;

  package CPU
    "Package that provides models of CPUs and sub-components like tasks and schedulers."

  annotation (Diagram,preferedView="info",Documentation(info="
<HTML>
<p>
The CPU package provides models that implement a CPU and contains the subpackages for tasks and schedulers.
</p>
<p>
The CPU models are regarded as wrapping instances for tasks and the scheduler. Ther architecture of a general CPU model is shown in Figure 1.
</p>
<p>
  <img src=\"../doc/images/CPUArchitecture.png\" width=\"700\">
</p>
<p>
<b>Figure 1: Architecture of a CPU model with tasks and scheduler instance.</b>
</p>
<p>
<ul>
  <li>
    Every CPU model contains one scheduler model (package <a href=\"Scheduler\">Scheduler</a>) which arbitrates the processing time between the tasks.
  </li>
  <li>
    The tasks (package <a href=\"Task\">Task</a>) are kept in a task assembly.
  </li>
  <li>
    The task assembly is divided in two sub-assemblies. One assembly containing tasks that do not process network messages, and the other assembly contains the tasks that do process network messages.
  </li>
  <li>
    The tasks with network access (<a href=\"Task.NetworkTask\">NetworkTask</a>) have connections to the send and receive queues of the transceiver model (see package <a href=\"Network\">Network</a>) that is connected to the network.
  </li>
  <li>
    All tasks have access to the process image of inputs and to the process image of outputs, as well as to the <a href=\"Controller.Memory.RAM\">RAM</a> which is used for intertask information exchange.
  </li>
</ul>
</HTML>
", revisions=
           "<html>
<ul>
<li><i>February 3rd, 2008</i>
       by <a href=\"http://www.eit.uni-kl.de/frey\">Florian Wagner</a>
</li>
</ul>
</html>"));
    model CPU "Model of a CPU with a scheduler and four tasks."
      extends Controller.Icons.Chip;

    annotation (preferedView="diagram",Diagram(
          Text(
            extent=[12,98; 92,78],
            string="Scheduler",
            style(color=0, rgbcolor={0,0,0})),
          Text(
            extent=[-116,-20; -80,-40],
            style(color=0, rgbcolor={0,0,0}),
            string="PIInputs"),
          Text(
            extent=[82,-18; 118,-38],
            style(color=0, rgbcolor={0,0,0}),
            string="PIOutputs")),
                        Documentation(info="
<HTML>
<p>
This is the base model for all CPU like components. It has access to process signals via the process images (see info of <a href=\"Controller.Board\">Controller.Board</a> package).
</p>
<p>
This CPU model can host up to four tasks (subpackage <a href=\"Task\">Task</a>) which are <u>not</u> processing network messages. The arbration of processing time between the tasks is done by a scheduler (subpackage <a href=\"Scheduler\">Scheduler</a>).
</p>
<p>
As the number of tasks is fixed in the model, the model <a href=\"Task.DummyTask\">DummyTask</a> can be used to define that a task is not present.
</p>
</HTML>
",   revisions=
             "<html>
<ul>
<li><i>February 2nd, 2008</i>
       by <a href=\"http://www.eit.uni-kl.de/frey\">Florian Wagner</a>
</li>
</ul>
</html>"));

      Controller.Memory.RAM rAM annotation (extent=[-40, -100; 0, -60]);
      annotation (Diagram(
          Text(
            extent=[-120, -20; -80, -40],
            style(color=0, rgbcolor={0,0,0}),
            string="PIInputs"),
          Text(
            extent=[80, -20; 120, -40],
            style(color=0, rgbcolor={0,0,0}),
            string="PIOutputs"),
          Text(
            extent=[20, 100; 80, 80],
            style(color=0, rgbcolor={0,0,0}),
            string="Scheduler")), Icon(Text(
            extent=[-100, -40; 100, -100],
            string="CPU",
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=4))));
      Controller.Interfaces.MemoryConnector PIInputs
        "The connector to the process image of inputs."
        annotation (extent=[-120, -20; -80, 20]);
      Controller.Interfaces.MemoryConnector PIOutputs
        "The connector to the process image of outputs."
        annotation (extent=[80, -20; 120, 20]);

      inner parameter Modelica.SIunits.Frequency CPUFreq=1e6;

      replaceable Task.DummyTask task1 extends Task.Task
        annotation (extent=[-70, 26; -50, 46], choicesAllMatching=true);
      replaceable Task.DummyTask task2 extends Task.Task
        annotation (extent=[-30, 26; -10, 46], choicesAllMatching=true);
      replaceable Task.DummyTask task3 extends Task.Task
        annotation (extent=[-70, -30; -50, -10], choicesAllMatching=true);
      replaceable Task.DummyTask task4 extends Task.Task
        annotation (extent=[-30, -30; -10, -10], choicesAllMatching=true);
    protected
      Controller.Interfaces.MemoryConnector rAMConnector2 annotation (extent=[-81,
            11; -79, 13], style(
          color=51,
          rgbcolor={255,255,85},
          thickness=2));
    protected
      Controller.Interfaces.MemoryConnector PIInputs3
        annotation (extent=[-37, 11; -35, 13]);
    protected
      Controller.Interfaces.MemoryConnector PIOutputs3
        annotation (extent=[-45, 19; -43, 21]);
    protected
      Controller.Interfaces.MemoryConnector PIOutputs6
        annotation (extent=[-5, 19; -3, 21]);
    protected
      Controller.Interfaces.MemoryConnector Memory1
        annotation (extent=[-61, 15; -59, 17]);
    protected
      Controller.Interfaces.MemoryConnector Memory2
        annotation (extent=[-61, -41; -59, -39]);
    protected
      Controller.Interfaces.MemoryConnector Memory3
        annotation (extent=[-21, 15; -19, 17]);
    protected
      Controller.Interfaces.MemoryConnector Memory5
        annotation (extent=[-21, -41; -19, -39]);
    protected
      Controller.Interfaces.MemoryConnector Memory7
        annotation (extent=[9, -41; 11, -39]);
    protected
      Controller.Interfaces.MemoryConnector Memory8
        annotation (extent=[9, 15; 11, 17]);
      Interfaces.SchedulingConnector schedulingConnector[numberOfTasks]
        annotation (extent=[-80, 58; 58, 62]);
      Interfaces.SchedulingConnector schedulingConnector1[numberOfTasks]
        annotation (extent=[-80, 0; 58, 4]);
    public
      replaceable Interfaces.IScheduler scheduler(numberOfTasks=numberOfTasks)
        extends Interfaces.IScheduler(numberOfTasks=numberOfTasks)
        "The scheduling component to arbitrate processing time between the tasks."
        annotation (extent=[-10, 78; 10, 98], choicesAllMatching=true);

      parameter Integer numberOfTasks=4 "The number of tasks in the CPU";
    equation

      //cardinality equations
      if (cardinality(PIInputs) < 2) then
        PIInputs = -1;
      end if;

      if (cardinality(PIOutputs) < 2) then
        PIOutputs = -1;
      end if;
      connect(PIInputs, rAMConnector2) annotation (points=[-100, 0; -80, 0; -80,
            12], style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4));
      connect(PIOutputs3, PIOutputs6) annotation (points=[-44, 20; -4, 20],
          style(
          color=43,
          rgbcolor={255,85,85},
          thickness=4));
      connect(task1.Memory, Memory1) annotation (points=[-60, 26; -60, 16],
          style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4));
      connect(task3.Memory, Memory2) annotation (points=[-60, -30; -60, -40],
          style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4));
      connect(Memory1, Memory3) annotation (points=[-60, 16; -20, 16], style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4));
      connect(task2.Memory, Memory3) annotation (points=[-20, 26; -20, 16],
          style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4));
      connect(Memory2, Memory5) annotation (points=[-60, -40; -20, -40], style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4));
      connect(Memory5, Memory7) annotation (points=[-20, -40; 10, -40], style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4));
      connect(Memory3, Memory8) annotation (points=[-20, 16; 10, 16], style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4));
      connect(Memory7, Memory8) annotation (points=[10, -40; 10, 16], style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4));
      connect(task1.PIInputs, rAMConnector2) annotation (points=[-70, 36; -80,
            36; -80, 12], style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4));
      connect(task3.PIInputs, rAMConnector2) annotation (points=[-70, -20; -80,
            -20; -80, 12],style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4));
      connect(task4.PIInputs, PIInputs3) annotation (points=[-30, -20; -36, -20;
            -36, 12],style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4));
      connect(PIInputs3, rAMConnector2) annotation (points=[-36, 12; -80, 12],
          style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4));
      connect(task2.PIInputs, PIInputs3) annotation (points=[-30, 36; -36, 36;
            -36, 12],style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4));
      connect(task4.Memory, Memory5) annotation (points=[-20, -30; -20, -40],
          style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4));
      connect(task1.PIOutputs, PIOutputs3) annotation (points=[-50, 36; -44, 36;
            -44, 20],style(
          color=43,
          rgbcolor={255,85,85},
          thickness=4));
      connect(task2.PIOutputs, PIOutputs6) annotation (points=[-10, 36; -4, 36;
            -4, 20],style(
          color=43,
          rgbcolor={255,85,85},
          thickness=4));
      connect(task4.PIOutputs, PIOutputs6) annotation (points=[-10, -20; -4, -20;
            -4, 20],style(
          color=43,
          rgbcolor={255,85,85},
          thickness=4));
      connect(task3.PIOutputs, PIOutputs3) annotation (points=[-50, -20; -44, -20;
            -44, 20],style(
          color=43,
          rgbcolor={255,85,85},
          thickness=4));
      connect(task1.scheduler, schedulingConnector[1]) annotation (points=[-60,46;
            -60,60; -62.75,60],    style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4));
      connect(task2.scheduler, schedulingConnector[2]) annotation (points=[-20,46;
            -20,60; -28.25,60],    style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4));
      connect(task3.scheduler, schedulingConnector1[3]) annotation (points=[-60,-10;
            -60,2; 6.25,2],       style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4));
      connect(task4.scheduler, schedulingConnector1[4]) annotation (points=[-20,-10;
            -20,2; 40.75,2],      style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4));
      connect(schedulingConnector1, schedulingConnector) annotation (points=[-11,
            2; 4, 2; 4, 60; -11, 60], style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4));
      connect(PIOutputs6, PIOutputs) annotation (points=[-4, 20; 80, 20; 80, 0;
            100, 0], style(
          color=43,
          rgbcolor={255,85,85},
          thickness=4));
      connect(scheduler.tasks, schedulingConnector) annotation (points=[0, 78;
            0, 60; -11, 60], style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4));
      connect(rAM.RAMIndex, Memory7) annotation (points=[-20,-92; 10,-92; 10,
            -40], style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4));
      connect(PIInputs, PIInputs) annotation (points=[-100, 0; -100, 0], style(
          pattern=0,
          thickness=4,
          fillColor=69,
          rgbfillColor={0,128,255},
          fillPattern=1));
    end CPU;

    model CPUWithNetwork
      "Model of a CPU with a scheduler and six tasks, four ordinary tasks and two tasks with network access."
      extends CPU(numberOfTasks=6);

    annotation (preferedView="diagram",Diagram(
          Text(
            extent=[12,98; 92,78],
            string="Scheduler",
            style(color=0, rgbcolor={0,0,0})),
          Text(
            extent=[-116,-20; -80,-40],
            style(color=0, rgbcolor={0,0,0}),
            string="PIInputs"),
          Text(
            extent=[82,-18; 118,-38],
            style(color=0, rgbcolor={0,0,0}),
            string="PIOutputs")),
                        Documentation(info="
<HTML>
<p>
This is the base model for all CPU like components. It has access to process signals via the process images (see info of <a href=\"Controller.Board\">Controller.Board</a> package).
</p>
<p>
This CPU model can host up to four tasks (subpackage <a href=\"Task\">Task</a>) which are <u>not</u> processing network messages, and two task which may process network messages. The arbration of processing time between the tasks is done by a scheduler (subpackage <a href=\"Scheduler\">Scheduler</a>).
</p>
<p>
As the number of tasks is fixed in the model, the model <a href=\"Task.DummyNetworkTask\">DummynetworkTask</a> can be used to define that a network task is not present.
</p>
</HTML>
",   revisions=
             "<html>
<ul>
<li><i>February 2nd, 2008</i>
       by <a href=\"http://www.eit.uni-kl.de/frey\">Florian Wagner</a>
</li>
</ul>
</html>"));

      Controller.Memory.RAM rAM annotation (extent=[-40, -100; 0, -60]);
      annotation (Diagram(Text(
            extent=[60, -80; 100, -100],
            style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
            string="Network")), Icon);

      parameter Integer address=1 "The network address of the CPU";
      replaceable Task.DummyNetworkTask networkTask1 extends Task.NetworkTask
        annotation (extent=[30, 26; 50, 46],choicesAllMatching=true);

      replaceable Task.DummyNetworkTask networkTask2 extends Task.NetworkTask
        annotation (extent=[30, -30; 50, -10],choicesAllMatching=true);

      Network.Interfaces.ICConnector iCConnector
        annotation (extent=[80, -80; 100, -60]);
    protected
      Network.Interfaces.ICConnector iCConnector1
        annotation (extent=[71, -29; 73, -27]);
    protected
      Network.Interfaces.ICConnector iCConnector2
        annotation (extent=[73, 27; 75, 29]);
    protected
      Controller.Interfaces.MemoryConnector PIInputs1
        annotation (extent=[19, 11; 21, 13]);
    protected
      Controller.Interfaces.MemoryConnector PIOutputs1
        annotation (extent=[55, 19; 57, 21]);
    equation
      connect(networkTask2.iCConnector, iCConnector1) annotation (points=[48,
            -28; 72, -28],style(
          color=2,
          rgbcolor={0,255,0},
          thickness=4,
          fillPattern=1));
      connect(iCConnector2, iCConnector1) annotation (points=[74, 28; 74, -28;
            72, -28],style(
          color=2,
          rgbcolor={0,255,0},
          thickness=4,
          fillPattern=1));
      connect(iCConnector1, iCConnector) annotation (points=[72, -28; 74, -28;
            74, -70; 90, -70], style(
          color=2,
          rgbcolor={0,255,0},
          thickness=4,
          fillPattern=1));
      connect(networkTask2.scheduler, schedulingConnector1[6]) annotation (
          points=[40,-10; 40,2; 46.5,2],   style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4,
          fillPattern=1));
      connect(networkTask1.scheduler, schedulingConnector[5]) annotation (
          points=[40,46; 40,60; 23.5,60],   style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4,
          fillPattern=1));
      connect(networkTask1.PIInputs, PIInputs1) annotation (points=[30, 36; 20,
            36; 20, 12],style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4,
          fillPattern=1));
      connect(PIInputs3, PIInputs1) annotation (points=[-36, 12; 20, 12], style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4,
          fillPattern=1));
      connect(networkTask2.PIInputs, PIInputs1) annotation (points=[30, -20; 20,
            -20; 20, 12],style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4,
          fillPattern=1));
      connect(networkTask1.PIOutputs, PIOutputs1) annotation (points=[50, 36;
            56, 36; 56, 20], style(
          color=43,
          rgbcolor={255,85,85},
          thickness=4,
          fillPattern=1));
      connect(networkTask2.PIOutputs, PIOutputs1) annotation (points=[50, -20;
            56, -20; 56, 20], style(
          color=43,
          rgbcolor={255,85,85},
          thickness=4,
          fillPattern=1));
      connect(networkTask2.Memory, Memory7) annotation (points=[40, -30; 40, -40;
            10, -40],style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4,
          fillPattern=1));
      connect(networkTask1.Memory, Memory8) annotation (points=[40, 26; 40, 16;
            10, 16],style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4,
          fillPattern=1));
      connect(PIOutputs6, PIOutputs1) annotation (points=[-4, 20; 56, 20],
          style(
          color=43,
          rgbcolor={255,85,85},
          thickness=4,
          fillPattern=1));
      connect(networkTask1.iCConnector, iCConnector2) annotation (points=[48,
            28; 74, 28], style(
          color=2,
          rgbcolor={0,255,0},
          thickness=4));
      connect(iCConnector, iCConnector) annotation (points=[90, -70; 90, -70],
          style(
          color=2,
          rgbcolor={0,255,0},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
    end CPUWithNetwork;

    package Scheduler "Package that contains models for schedulers."
      annotation(preferedView="info",Documentation(info="<html>
<p>
This package contains the scheduler models, which implement the arbitration instance for processing time.
</p>
<p>
All scheduler models must implement the <a href=\"Controller.Interfaces.IScheduler\">IScheduler</a> interface.
A convenient base class for implementations of scheduler models not contained in this Library is the <a href=\"Scheduler\">Scheduler</a> model.
</p>
<p>
The job of a scheduler model is to arbitrate the processing time in a <a href=\"Controller.CPU\">CPU</a>.
<b>Figure 1</b> shows the interactions between the tasks and the scheduler.<br>
<br>
<img src=\"../doc/images/SchedulerInterface.png\"><br>
<br>
All tasks (package <a href=\"Task\">Task</a>) in the <a href=\"Controller.CPU\">CPU</a> can request processing time at the scheduler.
Depending on the implemented scheduling policy, the scheduler selects one task to assign the processing time to.
</p>
</html>"));
      partial model Scheduler "Abstract base model for all scheduler models"
        extends Controller.Interfaces.IScheduler;

      annotation(preferedView="info",Documentation(info="<html>
<p>
This is an abstract base model for scheduler models. A scheduler is the abtritation instance for processing time in a <a href=\"Controller.CPU.CPU\">CPU</a> based on a certain schdeuling policy.<br>
More information about the scheduling instance in a <a href=\"Controller.CPU\">CPU</a> can be found the in the <a href=\"Controller.CPU.Scheduler\">Scheduler</a> package description.
</p>
<p>
All <a href=\"Controller.CPU.Task\">Tasks</a> in a CPU are connected to the scheduler using the <a href=\"Controller.Interfaces.SchedulingConnector\">SchedulingConnector</a>.
The tasks tell the scheduler if they want to run. Based on the implemented scheduling policy, the scheduler determines which task gets the processing time of the CPU.</p>
</html>"));
      end Scheduler;

      model RoundRobinScheduler
        "Scheduler model implementing the round robin scheduling policy"
        extends Controller.CPU.Scheduler.Scheduler;
      annotation(preferedView="info",Documentation(info="<html>
<p>
This scheduler model implements the round robin scheduling policy. The model extends the <a href=\"Controller.CPU.Scheduler.Scheduler\">Scheduler</a> base model.
</p>
<p>
The round robin scheduling policy is a time slice scheduling policy, i.e. running tasks can be preempted by the scheduler to give processing time to other tasks requesting for processing time.
</p>
<p>
<b>Figure 1</b> shows a typical situation for round robin scheduling with four tasks, where all tasks have the same behavior.<br>
<br>
<img src=\"../doc/images/RoundRobinScheduling.png\"><br>
<br>
<b>Figure 1: Typical situation for round robin scheduling.</b><br>
<br>
The job they have to do takes 8 ms of processing time. After finishing the job the tasks go to sleep for 10 ms. The scheduler is parameterized to use 1 ms time slices.
I.e., after 1 ms of processing time the currently running task is preempted and processing time is given to another task requesting for processing time.
</p>
<p>
The blue lines show the request signals of the tasks, while the red lines denote the run signals to the tasks.
</p>
<p>
The data of <b>Figure 1</b> has been generated with the <a href=\"Controller.Examples.SchedulingExperiments.RoundRobinTest\">RoundRobinTest</a> experiment, which illustrates
</p>
</html>"));
        //Parameters
        parameter Modelica.SIunits.Time timeSlice=0.01
          "The maximum length of a time slice given to a task";

        //State variables
        Modelica.SIunits.Time sliceTimer;
        Integer runningTask(start=0);
        Integer newRunningTask;
        //Auxiliary variables
        Boolean schedule;
        Integer taskSearchStart;
        //Integer i;
        //Boolean continueSearch;

        Integer schedulingCounter(start=0);
        //Boolean localRequest;
        //Integer currentlyRunningTask;
        Boolean requests[numberOfTasks];
        Boolean oldrequests[numberOfTasks];
        Boolean requestfalse;
      algorithm
        schedule := false;

        if (runningTask > 0) then
          requestfalse := oldrequests[runningTask] == false;
        else
          requestfalse := false;
        end if;

        when (runningTask == 0) then
          schedule := true;
        elsewhen (sliceTimer <= 0) then
          schedule := true;
        elsewhen (requestfalse) then
          schedule := true;
        end when;

        if (schedule) then

          if (runningTask <> 0) then
            newRunningTask := runningTask + 1;
            taskSearchStart := runningTask;
          else
            newRunningTask := 1;
            taskSearchStart := numberOfTasks;
          end if;

          if (newRunningTask > numberOfTasks) then
            newRunningTask := 1;
          end if;

          while (newRunningTask <> taskSearchStart and oldrequests[
              newRunningTask] == false) loop
            newRunningTask := newRunningTask + 1;
            if (newRunningTask > numberOfTasks) then
              newRunningTask := 1;
            end if;

          end while;

          runningTask := newRunningTask;
        end if;

        when (schedule) then
          schedulingCounter := schedulingCounter + 1;
        end when;

      equation
        for i in 1:numberOfTasks loop
          if (i == runningTask and tasks[i].request) then
            tasks[i].run = true;
          else
            tasks[i].run = false;
          end if;
        end for;

        if (runningTask <> 0) then
          der(sliceTimer) = -1;
        else
          der(sliceTimer) = 0;
        end if;
        when (schedule) then
          reinit(sliceTimer, timeSlice);
        end when;

        for i in 1:numberOfTasks loop
          requests[i] = tasks[i].request;
        end for;

        for i in 1:numberOfTasks loop
          oldrequests[i] = pre(requests[i]);
        end for;

        annotation (Icon(Text(
              extent=[-100, 100; 100, 40],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillColor=1,
                rgbfillColor={255,0,0},
                fillPattern=1),
              string="Round Robin")));
      end RoundRobinScheduler;

      annotation (Icon(
          Rectangle(extent=[-100, 100; 100, -100], style(color=0, rgbcolor={0,0,
                  0})),
          Rectangle(extent=[-100, 100; -50, 52], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1)),
          Rectangle(extent=[-50, 52; 0, 0], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=58,
              rgbfillColor={0,127,0},
              fillPattern=1)),
          Rectangle(extent=[0, 100; 30, 52], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Rectangle(extent=[30, 0; 80, -50], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=45,
              rgbfillColor={255,128,0},
              fillPattern=1)),
          Rectangle(extent=[80, -50; 100, -100], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=1,
              rgbfillColor={255,0,0},
              fillPattern=1)),
          Rectangle(extent=[-50, 100; 0, 52], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=69,
              rgbfillColor={0,128,255},
              fillPattern=7))));
      model FIFOScheduler
        "Scheduler model which implements a non-preemptive FIFO scheduling policy"
        extends Scheduler;

      annotation(preferedView="info",Documentation(info="<html>
<p>
This scheduler model implements a non-preemptive FIFO scheduling policy. The model extends the <a href=\"Controller.CPU.Scheduler.Scheduler\">Scheduler</a> base model.
</p>
<p>
The non-preemptive FIFO scheduling policy provides processing time to tasks in the order the tasks ask for processing ressources the first time.</p>
</p>
<b>Figure 1</b> shows a typical situation for FIFO scheduling with four tasks, where all tasks have the same behavior.<br>
<br>
<img src=\"../doc/images/FIFOScheduling.png\"><br>
<br>
<b>Figure 1: Typical situation for round robin scheduling.</b><br>
<br>
The job they have to do takes 8 ms of processing time. After finishing the job the tasks go to sleep for 10 ms.
Once the scheduler has given processing time to a task, the task is not preempted.
If other tasks are also requesting for processing time, they have to wait until the running task has finished its job.
</p>
<p>
The blue lines show the request signals of the tasks, while the red lines denote the run signals to the tasks.
</p>
</html>"), Icon(         Text(
              extent=[-100,100; 100,40],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillColor=1,
                rgbfillColor={255,0,0},
                fillPattern=1),
              string="non-preemptive FIFO")));
        //Parameters

        //Auxiliary variables
        Queueing.Queue taskQueue(size=numberOfTasks);

        Integer runningTask( start=0);
        Integer schedulingCounter( start=0);
        Boolean successful;
        //Boolean requests[numberOfTasks];
      algorithm

        //ensure that all requesting tasks are in the queue
        for i in 1:numberOfTasks loop
          if (tasks[i].request and not (Queueing.contains(taskQueue,i)) and not i==runningTask) then
            (,taskQueue.numberOfElements,taskQueue.elements):=Queueing.enqueue(taskQueue,i);
          end if;
        end for;

        //schedule
        when (runningTask<1 and not (Queueing.isEmpty(taskQueue))) then

         Modelica.Utilities.Streams.print("Time: "+String(time));
         Modelica.Utilities.Streams.print("elemente vorher: "+String(taskQueue.numberOfElements));
          (successful,runningTask,taskQueue.numberOfElements,taskQueue.elements):=Queueing.dequeue(taskQueue);
          Modelica.Utilities.Streams.print("elemente nachher: "+String(taskQueue.numberOfElements));

          schedulingCounter:=schedulingCounter+1;
        elsewhen
                (runningTask>0 and tasks[runningTask].jobFinished) then

          Modelica.Utilities.Streams.print("Time: "+String(time));
          Modelica.Utilities.Streams.print("elemente vorher: "+String(taskQueue.numberOfElements));

          if (not
                 (Queueing.isEmpty(taskQueue))) then
            (successful,runningTask,taskQueue.numberOfElements,taskQueue.elements):=Queueing.dequeue(taskQueue);
          else
            runningTask:=0;
          end if;
         Modelica.Utilities.Streams.print("elemente nachher: "+String(taskQueue.numberOfElements));

          Modelica.Utilities.Streams.print("runningTask: "+String(runningTask));
          schedulingCounter:=schedulingCounter+1;
        end when;

      equation
        for i in 1:numberOfTasks loop
          if (i==pre(runningTask)) then
            tasks[i].run= true;
          else
            tasks[i].run= false;
          end if;
        end for;

        /*for i in 1:numberOfTasks loop
    requests[i]=tasks[i].request;
  end for;*/

        annotation (Icon(Text(
              extent=[-100, 100; 100, 40],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillColor=1,
                rgbfillColor={255,0,0},
                fillPattern=1),
              string="Round Robin")));

      end FIFOScheduler;

    end Scheduler;

    package Task "Package that contains models for tasks."
      annotation(preferedView="info",Documentation(info="<html>
<p>
This package contains models that implement tasks in <a href=\"Controller.CPU\">CPU</a>.
</p>
<p>
The models for tasks can be divided in two assemblies:
<ul>
  <li>Tasks <u>without</u> network access (extending <a href=\"Task\">Task</a>).</li>
  <li>Tasks <u>with</u> network access (extending <a href=\"NetworkTask\">NetworkTask</a>).</li>
</ul>
</p>
<p>
A general description about the mode of operation of all tasks (in the sense of this library) can be found in the description of the <a href=\"Task\">Task</a> model.
</p>
</html>"));
      partial model Task
        "This model is the base class for processes running in a CPU model"
        extends Controller.Interfaces.ITask;
        annotation(preferedView="info",Documentation(info="<html>
<p>
This is the base class for all user defined tasks. A task is a software process that runs quasi-concurrently to other software processes in a CPU.
</p>
<p>
The behavior of a task is defined by a state machine as shown in the Figure 1.<br>
<br>
<img src=\"../doc/images/TaskStateMachine.png\" width=\"600\"><br>
<b>Figure 1: Behavior of a task described as a state machine.</b>
</p>
<p>The task is controlled by four input variables as shown in Table 1.<br>
  <br>
  <b>Table 1: Input variables for the state machine controlling the task behavior</b><br>
  <br>
  <table border=\"1\">
    <tr><td><b>variable name</b></td><td><b>variable type</b></td><td><b>source</b></td><td><b>description</b></td><tr>
    <tr><td>idle</td><td>Boolean</td><td>task model itself</td><td>true: forces the task to go to idle state, false: nothing</td></tr>
    <tr><td>run</td><td>Boolean</td><td><a href=\"Controller.CPU.Scheduler.Scheduler\">Scheduler</a></td><td>true: task is gets processing time and is running, false: task does not get processing time</td></tr>
    <tr><td>runTime</td><td><a href=\"Modelica.SIunits.Time\">Time</a></td><td>task model itself</td><td>determines the processing time needed to finish the current job (function of processing cycles)</td></tr>
    <tr><td>sleepTime</td><td><a href=\"Modelica.SIunits.Time\">Time</a></td><td>task model itself</td><td>determines how long the task should not request for processing time</td></tr>
  </table>
</p>
<p>The only output variable <i>request</i> informs the <a href=\"Controller.CPU.Scheduler.Scheduler\">Scheduler</a> if the task needs processing time.</p>
<p>In the states, behavior of the task is described by the deravites of the continuous state variables <i>runTimer<I> and <i>sleepTimer</i>, which are used in the transition conditions of the state machine.</p>
<p>When the current job of the task is finished, the <i>jobFinished</i> event is raised and has to be treated by user defined code in extension modesl of the task model (e.g. <a href=\"Controller.Examples.PLCPIDController.PIDTask\">PIDTask</a>).</p>

</html>"),       Diagram(
            Text(
              extent=[62,-12; 122,-32],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=4),
              string="process image of outputs"),
            Text(
              extent=[16,104; 50,70],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=4),
              string="scheduler"),
            Text(
              extent=[-38,-86; -16,-92],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=4),
              string="RAM"),
            Rectangle(extent=[-60,60; 60,-60], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=4)),
            Line(points=[-84,0; -60,0], style(
                color=0,
                rgbcolor={0,0,0},
                pattern=2,
                thickness=4)),
            Line(points=[60,0; 84,0], style(
                color=0,
                rgbcolor={0,0,0},
                pattern=2,
                thickness=4)),
            Line(points=[0,-60; 0,-84], style(
                color=0,
                rgbcolor={0,0,0},
                pattern=2,
                thickness=4)),
            Line(points=[0,84; 0,60], style(
                color=0,
                rgbcolor={0,0,0},
                pattern=2,
                thickness=4)),
            Text(
              extent=[-124,-18; -64,-38],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=4),
              string="process image of inputs"),
            Bitmap(extent=[-56,58; 56,-58], name="doc/images/TaskStateMachine.png")));
        import Controller;

      equation
        if (scheduler.run) then
          der(runTimer) = 1;
          der(sleepTimer) = 0;
        else
          der(runTimer) = 0;
          der(sleepTimer) = -1;
        end if;

        if (cardinality(PIInputs) < 1) then
          PIInputs = -1;
        end if;

        if (cardinality(PIOutputs) < 1) then
          PIOutputs = -1;
        end if;

        if (cardinality(Memory) < 1) then
          Memory = -1;
        end if;

      algorithm
        jobFinished := false;
        when (runTimer > runTime and time > 0) then
          jobFinished := true;
        end when;

        scheduler.request := true;
        if (sleepTimer > 0 or idle) then
          scheduler.request := false;
        end if;

        scheduler.jobFinished:=jobFinished;
        annotation (Diagram, Icon(Text(
              extent=[-100, 100; 100, 40],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillColor=55,
                rgbfillColor={170,255,85},
                fillPattern=1),
              string="%name")));
      end Task;

      partial model NetworkTask
        "This model is the base class for processes running in a CPUWithNetwork model"
        extends Controller.CPU.Task.Task;
        extends Controller.Interfaces.INetworkTask;
        annotation(preferedView="info",Documentation(info="<html>
<p>
This is the base class for all user defined tasks with network access. It extends the <a href=\"Controller.CPU.Task.Task\">Task</a> model.
</p>
<p>
In principle, the behavior of a networktask is the same as defined in the <a href=\"Controller.CPU.Task.Task\">Task</a> model.
In addition, a NetworkTask has access to the send and receive queues of the <a href=\"Network.Protocol_Mainclass_replacable.CSMA_CA_transceivermodul\">Trensceivermodule</a> via the <a href=\"Network.INterfaces.IC_Connector\">IC_Connector</a>.
</html>"));
        annotation (Diagram);
      end NetworkTask;

      model ExternalTask
        extends Task;
        replaceable function algorithmCall =
            Controller.CPU.Task.Functions.algorithmCall extends
          Controller.CPU.Task.Functions.algorithmCall annotation (
            choicesAllMatching);

        parameter Integer ni=1 "number of input signals";
        parameter Integer no=1 "number of output signals";

        Real inputSignals[ni];
        Real outputSignals[no];
        Boolean outputSignalsMask[no];

        Integer newRunTimeCycles;
        Modelica.SIunits.Time newSleepTime;
        Boolean resetRunTimer;
        Boolean resetSleepTimer;
        Boolean updateRunTime;
        Boolean updateSleepTime;

      algorithm
        when (pre(jobFinished)) then

          //get current image of input signals
          for i in 1:ni loop
            inputSignals[i] := Controller.Memory.Functions.readReal(PIInputs, i);
          end for;

          (newRunTimeCycles,newSleepTime,updateRunTime,updateSleepTime,
            resetRunTimer,resetSleepTimer,outputSignals,outputSignalsMask) :=
            algorithmCall(
                  inputSignals,
                  ni,
                  no);

          if (updateRunTime) then
            runTime := newRunTimeCycles/CPUFreq;
          end if;

          if (updateSleepTime) then
            sleepTime := newSleepTime;
          end if;

          if (resetRunTimer) then
            reinit(runTimer, 0);
          end if;

          if (resetSleepTimer) then
            reinit(sleepTimer, sleepTime);
          end if;

          //write new set values to process image of outputs
          for i in 1:no loop
            if (outputSignalsMask[i]) then
              Controller.Memory.Functions.writeReal(
                      PIOutputs,
                      i,
                      outputSignals[i]);
            end if;
          end for;
        end when;

      end ExternalTask;

      model ExternalNetworkTask
        extends NetworkTask;
        replaceable function algorithmCall =
            Controller.CPU.Task.Functions.algorithmCall extends
          Controller.CPU.Task.Functions.algorithmCall annotation (
            choicesAllMatching);

        parameter Integer ni=1 "number of input signals";
        parameter Integer no=1 "number of output signals";

        Real inputSignals[ni];
        Real outputSignals[no];
        Boolean outputSignalsMask[no];

          Integer newRunTimeCycles;
        Modelica.SIunits.Time newSleepTime;
      Boolean resetRunTimer;
        Boolean resetSleepTimer;
        Boolean updateRunTime;
        Boolean updateSleepTime;

      algorithm
        when (pre(jobFinished)) then

          //get current image of input signals
          for i in 1:ni loop
            inputSignals[i] := Controller.Memory.Functions.readReal(PIInputs, i);
          end for;

          (newRunTimeCycles,newSleepTime,updateRunTime,updateSleepTime,
            resetRunTimer,resetSleepTimer,outputSignals,outputSignalsMask) :=
            externalAlgorithmCall(
                  inputSignals,
                  ni,
                  no);

          if (updateRunTime) then
            runTime := newRunTimeCycles/CPUFreq;
          end if;

          if (updateSleepTime) then
            sleepTime := newSleepTime;
          end if;

          if (resetRunTimer) then
            reinit(runTimer, 0);
          end if;

          if (resetSleepTimer) then
            reinit(sleepTimer, sleepTime);
          end if;

          //write new set values to process image of outputs
          for i in 1:no loop
            if (outputSignalsMask[i]) then
              Controller.Memory.Functions.writeReal(
                      PIOutputs,
                      i,
                      outputSignals[i]);
            end if;
          end for;
        end when;

      end ExternalNetworkTask;

      model DummyTask
        "Task model that is used to determine that is task in a CPU is not present."
        extends Controller.CPU.Task.Task;
      equation
        idle = true;
        runTime = 0;
        sleepTime = 0;
        annotation (Diagram, Icon(Line(points=[-100, 100; 100, -100], style(
                color=1,
                rgbcolor={255,0,0},
                thickness=4)), Line(points=[-100, -100; 100, 100], style(
                color=1,
                rgbcolor={255,0,0},
                thickness=4))));
      end DummyTask;

      model DummyNetworkTask
        "Task model that is used to determine that a NetworkTask is not present."
        extends NetworkTask;

      equation
        idle = true;
        runTime = 0;
        sleepTime = 0;
        annotation (Diagram, Icon(Line(points=[-100, 100; 100, -100], style(
                color=1,
                rgbcolor={255,0,0},
                thickness=4)), Line(points=[-100, -100; 100, 100], style(
                color=1,
                rgbcolor={255,0,0},
                thickness=4))));
      end DummyNetworkTask;

      annotation (Icon(
          Rectangle(extent=[-100, 80; -80, -80], style(
              pattern=0,
              fillColor=69,
              rgbfillColor={0,128,255})),
          Rectangle(extent=[-34, 12; -24, -48], style(
              pattern=0,
              fillColor=69,
              rgbfillColor={0,128,255})),
          Rectangle(extent=[-56, -10; -4, -20], style(
              pattern=0,
              fillColor=69,
              rgbfillColor={0,128,255})),
          Rectangle(extent=[20, 80; 100, 60], style(
              pattern=0,
              fillColor=69,
              rgbfillColor={0,128,255})),
          Rectangle(extent=[20, 8; 100, -12], style(
              pattern=0,
              fillColor=69,
              rgbfillColor={0,128,255})),
          Rectangle(extent=[20, -60; 100, -80], style(
              pattern=0,
              fillColor=69,
              rgbfillColor={0,128,255})),
          Rectangle(extent=[80, -12; 100, -60], style(
              pattern=0,
              fillColor=69,
              rgbfillColor={0,128,255})),
          Rectangle(extent=[20, 60; 40, 8], style(
              pattern=0,
              fillColor=69,
              rgbfillColor={0,128,255}))));

      model ParasitaryTask
        "Task that is used to include processing time consuming tasks in a CPU, without a specified behavior."
        extends Task;

        parameter Integer cyclesPerJob=1000
          "processor cycles needed to finish the job";
        parameter Modelica.SIunits.Time sleepTimeBetweenJobs=0
          "time to sleep between two jobs";
      algorithm
        idle:=false;
        sleepTime:=0;
        runTime:=cyclesPerJob/CPUFreq;
        sleepTime:=sleepTimeBetweenJobs;
        when (pre(jobFinished)) then

          reinit(runTimer,0);
          if (sleepTimeBetweenJobs>0) then
            reinit(sleepTimer,sleepTime);
          end if;
        end when;
      end ParasitaryTask;

      package Functions
        partial function algorithmCall
          input Real inputSignals[numberOfInputSignals];
          input Integer numberOfInputSignals;
          input Integer numberOfOutputSignals;
          output Modelica.SIunits.Time runTime;
          output Modelica.SIunits.Time sleepTime;
          output Boolean updateRunTime;
          output Boolean updateSleepTime;
          output Boolean resetRunTimer;
          output Boolean resetSleepTimer;
          output Real outputSignals[numberOfOutputSignals];
          output Boolean outputSignalsMask[numberOfOutputSignals];
        algorithm

        end algorithmCall;

      end Functions;

    end Task;

    annotation (Icon(
        Rectangle(extent=[-80, 80; 80, -80], style(
            pattern=0,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1)),
        Line(points=[-56, 8; -56, -56], style(
            color=7,
            rgbcolor={255,255,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-56, -18; -24, -18], style(
            color=7,
            rgbcolor={255,255,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-24, 8; -24, -18], style(
            color=7,
            rgbcolor={255,255,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[2, 50; 2, -18], style(
            color=7,
            rgbcolor={255,255,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[2, 50; 34, 50], style(
            color=7,
            rgbcolor={255,255,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[2, 14; 34, 14], style(
            color=7,
            rgbcolor={255,255,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[34, 50; 34, 14], style(
            color=7,
            rgbcolor={255,255,255},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-60, 80; -60, 100], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-20, 80; -20, 100], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[20, 80; 20, 100], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[60, 80; 60, 100], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[100, 60; 80, 60], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[100, 20; 80, 20], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[100, -20; 80, -20], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[100, -60; 80, -60], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-80, -60; -100, -60], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-80, -20; -100, -20], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-80, 20; -100, 20], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-80, 60; -100, 60], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-60, -100; -60, -80], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-20, -100; -20, -80], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[20, -100; 20, -80], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[60, -100; 60, -80], style(
            color=9,
            rgbcolor={175,175,175},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1))));
    model CPUWithNetwork1
      "Model of a CPU with a scheduler and six tasks, four ordinary tasks and two tasks with network access."
      extends CPU(numberOfTasks=6,
        redeclare Examples.PLCPIDController.PLCTask task1,
        redeclare Examples.PLCPIDController.PLCTask task2);

    annotation (preferedView="diagram",Diagram(
          Text(
            extent=[12,98; 92,78],
            string="Scheduler",
            style(color=0, rgbcolor={0,0,0})),
          Text(
            extent=[-116,-20; -80,-40],
            style(color=0, rgbcolor={0,0,0}),
            string="PIInputs"),
          Text(
            extent=[82,-18; 118,-38],
            style(color=0, rgbcolor={0,0,0}),
            string="PIOutputs")),
                        Documentation(info="
<HTML>
<p>
This is the base model for all CPU like components. It has access to process signals via the process images (see info of <a href=\"Controller.Board\">Controller.Board</a> package).
</p>
<p>
This CPU model can host up to four tasks (subpackage <a href=\"Task\">Task</a>) which are <u>not</u> processing network messages, and two task which may process network messages. The arbration of processing time between the tasks is done by a scheduler (subpackage <a href=\"Scheduler\">Scheduler</a>).
</p>
<p>
As the number of tasks is fixed in the model, the model <a href=\"Task.DummyNetworkTask\">DummynetworkTask</a> can be used to define that a network task is not present.
</p>
</HTML>
",   revisions=
             "<html>
<ul>
<li><i>February 2nd, 2008</i>
       by <a href=\"http://www.eit.uni-kl.de/frey\">Florian Wagner</a>
</li>
</ul>
</html>"));

      Controller.Memory.RAM rAM annotation (extent=[-40, -100; 0, -60]);
      annotation (Diagram(Text(
            extent=[60, -80; 100, -100],
            style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1),
            string="Network")), Icon);

      parameter Integer address=1 "The network address of the CPU";
      replaceable Examples.NCSExample.SendTask networkTask1
                                                     extends Task.NetworkTask
        annotation (extent=[30, 26; 50, 46],choicesAllMatching=true);

      replaceable Examples.NCSExample.ReceiveTask networkTask2
                                                     extends Task.NetworkTask
        annotation (extent=[30, -30; 50, -10],choicesAllMatching=true);

      Network.Interfaces.ICConnector iCConnector
        annotation (extent=[80, -80; 100, -60]);
    protected
      Network.Interfaces.ICConnector iCConnector1
        annotation (extent=[71, -29; 73, -27]);
    protected
      Network.Interfaces.ICConnector iCConnector2
        annotation (extent=[73, 27; 75, 29]);
    protected
      Controller.Interfaces.MemoryConnector PIInputs1
        annotation (extent=[19, 11; 21, 13]);
    protected
      Controller.Interfaces.MemoryConnector PIOutputs1
        annotation (extent=[55, 19; 57, 21]);
    equation
      connect(networkTask2.iCConnector, iCConnector1) annotation (points=[48,
            -28; 72, -28],style(
          color=2,
          rgbcolor={0,255,0},
          thickness=4,
          fillPattern=1));
      connect(iCConnector2, iCConnector1) annotation (points=[74, 28; 74, -28;
            72, -28],style(
          color=2,
          rgbcolor={0,255,0},
          thickness=4,
          fillPattern=1));
      connect(iCConnector1, iCConnector) annotation (points=[72, -28; 74, -28;
            74, -70; 90, -70], style(
          color=2,
          rgbcolor={0,255,0},
          thickness=4,
          fillPattern=1));
      connect(networkTask2.scheduler, schedulingConnector1[6]) annotation (
          points=[40,-10; 40,2; 46.5,2],   style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4,
          fillPattern=1));
      connect(networkTask1.scheduler, schedulingConnector[5]) annotation (
          points=[40,46; 40,60; 23.5,60],   style(
          color=0,
          rgbcolor={0,0,0},
          thickness=4,
          fillPattern=1));
      connect(networkTask1.PIInputs, PIInputs1) annotation (points=[30, 36; 20,
            36; 20, 12],style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4,
          fillPattern=1));
      connect(PIInputs3, PIInputs1) annotation (points=[-36, 12; 20, 12], style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4,
          fillPattern=1));
      connect(networkTask2.PIInputs, PIInputs1) annotation (points=[30, -20; 20,
            -20; 20, 12],style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4,
          fillPattern=1));
      connect(networkTask1.PIOutputs, PIOutputs1) annotation (points=[50, 36;
            56, 36; 56, 20], style(
          color=43,
          rgbcolor={255,85,85},
          thickness=4,
          fillPattern=1));
      connect(networkTask2.PIOutputs, PIOutputs1) annotation (points=[50, -20;
            56, -20; 56, 20], style(
          color=43,
          rgbcolor={255,85,85},
          thickness=4,
          fillPattern=1));
      connect(networkTask2.Memory, Memory7) annotation (points=[40, -30; 40, -40;
            10, -40],style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4,
          fillPattern=1));
      connect(networkTask1.Memory, Memory8) annotation (points=[40, 26; 40, 16;
            10, 16],style(
          color=69,
          rgbcolor={0,128,255},
          thickness=4,
          fillPattern=1));
      connect(PIOutputs6, PIOutputs1) annotation (points=[-4, 20; 56, 20],
          style(
          color=43,
          rgbcolor={255,85,85},
          thickness=4,
          fillPattern=1));
      connect(networkTask1.iCConnector, iCConnector2) annotation (points=[48,
            28; 74, 28], style(
          color=2,
          rgbcolor={0,255,0},
          thickness=4));
      connect(iCConnector, iCConnector) annotation (points=[90, -70; 90, -70],
          style(
          color=2,
          rgbcolor={0,255,0},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1));
    end CPUWithNetwork1;
  end CPU;

  package Icons "Package that contains Icons for components."
    model Chip
      annotation (Icon(
          Polygon(points=[0, -20; 60, 40; 60, 20; 0, -40; 0, -20], style(
              pattern=0,
              fillColor=0,
              rgbfillColor={0,0,0},
              fillPattern=1)),
          Polygon(points=[-80, 0; 0, -20; 60, 40; -20, 60; -80, 0], style(
              pattern=0,
              fillColor=0,
              rgbfillColor={0,0,0})),
          Line(points=[0, -20; 0, -40], style(color=3, rgbcolor={0,0,255})),
          Line(points=[60, 40; 60, 20], style(color=3, rgbcolor={0,0,255})),
          Polygon(points=[-76, -10; -72, -6; -72, -26; -76, -30; -76, -10],
              style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=9,
              rgbfillColor={175,175,175})),
          Polygon(points=[-66, 0; -62, 4; -62, -16; -66, -20; -66, 0], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=9,
              rgbfillColor={175,175,175})),
          Polygon(points=[-56, 10; -52, 14; -52, -6; -56, -10; -56, 10], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=9,
              rgbfillColor={175,175,175})),
          Polygon(points=[-46, 20; -42, 24; -42, 4; -46, 0; -46, 20], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=9,
              rgbfillColor={175,175,175})),
          Polygon(points=[-36, 30; -32, 34; -32, 14; -36, 10; -36, 30], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=9,
              rgbfillColor={175,175,175})),
          Polygon(points=[-26, 40; -22, 44; -22, 24; -26, 20; -26, 40], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=9,
              rgbfillColor={175,175,175})),
          Polygon(points=[-80, 0; -20, 60; -20, 40; -80, -20; -80, 0], style(
              pattern=0,
              fillColor=0,
              rgbfillColor={0,0,0},
              fillPattern=1)),
          Polygon(points=[-80, -20; 0, -40; 60, 20; -20, 40; -80, -20], style(
              pattern=0,
              fillColor=0,
              rgbfillColor={0,0,0})),
          Polygon(points=[54, 20; 58, 24; 58, 4; 54, 0; 54, 20], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=9,
              rgbfillColor={175,175,175})),
          Polygon(points=[44, 10; 48, 14; 48, -6; 44, -10; 44, 10], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=9,
              rgbfillColor={175,175,175})),
          Polygon(points=[34, 0; 38, 4; 38, -16; 34, -20; 34, 0], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=9,
              rgbfillColor={175,175,175})),
          Polygon(points=[24, -10; 28, -6; 28, -26; 24, -30; 24, -10], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=9,
              rgbfillColor={175,175,175})),
          Polygon(points=[14, -20; 18, -16; 18, -36; 14, -40; 14, -20], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=9,
              rgbfillColor={175,175,175})),
          Polygon(points=[4, -32; 8, -28; 8, -48; 4, -52; 4, -32], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=9,
              rgbfillColor={175,175,175})),
          Text(
            extent=[-100, 100; 100, 60],
            style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1),
            string="%name")));
    end Chip;
    annotation (Diagram, Icon);
    model Utilities
      annotation (Icon);
    end Utilities;
  end Icons;

  package Interfaces
    "Package that contains connectors and interfaces for various models."
    connector SchedulingConnector
      Boolean run;
      Boolean request;
      Boolean jobFinished;
      //Integer priority;
      annotation (Icon(Rectangle(extent=[-80, 80; 80, -80], style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=55,
              rgbfillColor={170,255,85},
              fillPattern=1))));
    end SchedulingConnector;

    connector MemoryConnector = Integer "Connector to publish index of RAM"
      annotation (Icon(Rectangle(extent=[-80, 80; 80, -80], style(
            pattern=0,
            gradient=3,
            fillColor=10,
            rgbfillColor={95,95,95}))));
    model IIOBoard
      extends Controller.Interfaces.IBoard;
      Modelica.Blocks.Interfaces.RealInput u[ni] "the analog inputs signals"
        annotation (extent=[-140, -20; -100, 20]);
      Modelica.Blocks.Interfaces.RealOutput y[no] "the analog output signals"
        annotation (extent=[100, -10; 120, 10]);
      annotation (Icon(
          Rectangle(extent=[-100, 20; -60, -20], style(color=0, rgbcolor={0,0,0})),
          Rectangle(extent=[60, 20; 100, -20], style(color=0, rgbcolor={0,0,0})),
          Line(points=[-70, -34; -70, -20], style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1)),
          Line(points=[70, -34; 70, -20], style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1))), Diagram);

      parameter Integer ni=10 "number of analog inputs";
      parameter Integer no=10 "number of analog outputs";

    equation
      //cardinality check for the input signals
      for i in 1:ni loop
        if (cardinality(u[i]) < 2) then
          u[i] = 0;
        end if;
      end for;
    end IIOBoard;

    model INetworkIOBoard
      extends Controller.Interfaces.IIOBoard;
      extends Controller.Interfaces.INetworkBoard;
      annotation (Diagram);
    end INetworkIOBoard;

    model INetworkBoard
      extends Controller.Interfaces.IBoard;
      replaceable Network.Interfaces.NetworkPort networkPort
        annotation (extent=[-10, -90; 10, -70]);
      annotation (Diagram, Icon(Rectangle(extent=[-20, -60; 20, -100], style(
                color=0, rgbcolor={0,0,0})), Line(points=[0, -60; 0, -46],
              style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1))));
      parameter Integer address=1 "The network address of the embedded device";
    end INetworkBoard;

    partial model IBoard
      annotation (Icon(
          Rectangle(extent=[-100, 100; 100, -100], style(color=0, rgbcolor={0,0,
                  0})),
          Rectangle(extent=[-20, 20; 20, -20], style(color=0, rgbcolor={0,0,0})),
          Rectangle(extent=[-80, -34; 80, -46], style(color=0, rgbcolor={0,0,0})),
          Line(points=[0, -34; 0, -20], style(
              color=0,
              rgbcolor={0,0,0},
              fillPattern=1)),
          Text(
            extent=[-100, 100; 100, 40],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              arrow=3,
              fillColor=0,
              rgbfillColor={0,0,0},
              fillPattern=1),
            string="%name")));

    end IBoard;

    partial model IADConverter
      extends Controller.Icons.Chip;
      parameter Integer n=10 "number of analog inputs";
      Modelica.Blocks.Interfaces.RealInput analogInputs[n]
        annotation (extent=[-120, -20; -80, 20]);
      Controller.Interfaces.MemoryConnector PIInputs
        annotation (extent=[60, -20; 100, 20], rotation=180);
      annotation (Icon(Text(
            extent=[-100, -60; 100, -100],
            style(
              color=0,
              rgbcolor={0,0,0},
              pattern=0,
              gradient=3,
              fillColor=10,
              rgbfillColor={95,95,95}),
            string="ADC")), Diagram);

    equation
      for i in 1:n loop
        if (cardinality(analogInputs[i]) < 1) then
          analogInputs[i] = 0;
        end if;
      end for;

      assert(cardinality(PIInputs) > 0,
        "There must be a memory unit connected to the AD-Converter");
    end IADConverter;

    partial model IDAConverter
      extends Controller.Icons.Chip;
      Modelica.Blocks.Interfaces.RealOutput analogOutputs[n]
        annotation (extent=[80, -10; 100, 10]);
      Controller.Interfaces.MemoryConnector PIOutputs
        annotation (extent=[-120, -20; -80, 20]);

      //parameter variables
      parameter Integer n=10 "number of analog outputs";

    equation
      assert(cardinality(PIOutputs) > 0,
        "There must be a memory unit connected to the DA-Converter");
      annotation (Icon(Text(
            extent=[-100, -60; 100, -100],
            style(
              color=0,
              rgbcolor={0,0,0},
              pattern=0,
              gradient=3,
              fillColor=10,
              rgbfillColor={95,95,95}),
            string="DAC")));
    end IDAConverter;

    partial model ITask
      import Controller;

      Controller.Interfaces.SchedulingConnector scheduler
        annotation (extent=[-20, 80; 20, 120]);

      Modelica.SIunits.Time runTimer(start=0);
      Modelica.SIunits.Time sleepTimer(start=0);
      Controller.Interfaces.MemoryConnector PIInputs annotation (extent=[-120,
            -20; -80, 20], style(
          color=47,
          rgbcolor={255,170,85},
          thickness=4));
      Controller.Interfaces.MemoryConnector Memory
        annotation (extent=[-20, -120; 20, -80], rotation=90);
      Controller.Interfaces.MemoryConnector PIOutputs
        annotation (extent=[80, -20; 120, 20], rotation=180);

      Boolean idle(start=false);
      Modelica.SIunits.Time runTime(start=0);
      Modelica.SIunits.Time sleepTime(start=0);

      Boolean jobFinished(start=false);
    protected
      outer constant Modelica.SIunits.Frequency CPUFreq;

      annotation (Diagram, Icon(
          Text(
            extent=[-100, 100; 100, 40],
            style(
              color=0,
              rgbcolor={0,0,0},
              thickness=2,
              fillColor=55,
              rgbfillColor={170,255,85},
              fillPattern=1),
            string="%name"),
          Rectangle(extent=[-60, 40; 60, -60], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Rectangle(extent=[-70, 10; -50, -10], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=45,
              rgbfillColor={255,128,0},
              fillPattern=1)),
          Rectangle(extent=[-30, 10; -10, -10], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=45,
              rgbfillColor={255,128,0})),
          Rectangle(extent=[10, 10; 30, -10], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=45,
              rgbfillColor={255,128,0})),
          Rectangle(extent=[50, 10; 70, -10], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=7,
              rgbfillColor={255,255,255},
              fillPattern=1)),
          Line(points=[-48, 0; -32, 0], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=45,
              rgbfillColor={255,128,0},
              fillPattern=1)),
          Line(points=[-8, 0; 8, 0], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=45,
              rgbfillColor={255,128,0},
              fillPattern=1)),
          Line(points=[32, 0; 48, 0], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=45,
              rgbfillColor={255,128,0},
              fillPattern=1))));
    end ITask;

    partial model INetworkTask
      extends Controller.Interfaces.ITask;
      Network.Interfaces.ICConnector iCConnector
        annotation (extent=[60, -100; 100, -60]);

      parameter Integer address=1 "The network address of the task";

      //auxiliary variables
      Integer sndCacheID;
      Integer rcvCacheID;

    equation
      sndCacheID = iCConnector.cacheBusConnector.sendCacheID;
      rcvCacheID = iCConnector.cacheBusConnector.rcvCacheID;
    algorithm

      annotation (Diagram);
    end INetworkTask;

    partial model IScheduler

      annotation (Icon(
          Rectangle(extent=[-100, 40; 100, -80], style(color=0, rgbcolor={0,0,0})),
          Rectangle(extent=[-100, 40; -50, 10], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=3,
              rgbfillColor={0,0,255},
              fillPattern=1)),
          Rectangle(extent=[-50, 10; 0, -20], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=58,
              rgbfillColor={0,127,0},
              fillPattern=1)),
          Rectangle(extent=[0, 40; 30, 10], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=3,
              rgbfillColor={0,0,255})),
          Rectangle(extent=[30, -20; 80, -50], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=45,
              rgbfillColor={255,128,0},
              fillPattern=1)),
          Rectangle(extent=[80, -50; 100, -80], style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=1,
              rgbfillColor={255,0,0},
              fillPattern=1)),
          Rectangle(extent=[-50, 40; 0, 10],style(
              color=0,
              rgbcolor={0,0,0},
              fillColor=69,
              rgbfillColor={0,128,255},
              fillPattern=7))), Diagram);

      parameter Integer numberOfTasks=4
        "number of tasks handled by the scheduler";
      SchedulingConnector tasks[numberOfTasks]
        "the connectors for the tasks (as an array of connectors)"
        annotation (extent=[-20, -120; 20, -80]);
    end IScheduler;
  end Interfaces;

  package ProcessInterface
    "Package that contains models to interface physical models to embedded devices"
    annotation (preferedView="info",Icon(
        Line(points=[-100, 0; 100, 100], style(color=71, rgbcolor={85,170,255})),
        Line(points=[-100, 0; 100, 0], style(color=0, rgbcolor={0,0,0})),
        Line(points=[-100, -100; -80, -100; -80, -100; -60, -100; -60, -80; -60,
              -80; -20, -80; -20, -80; -20, -80; -20, -80; -20, -80; -20, -80;
              -20, -60; 20, -60; 20, -40; 20, -40; 20, -40; 60, -40; 60, -20;
              100, -20; 100, 0; 100, 0], style(color=43, rgbcolor={255,85,85})),
        Line(points=[-50, 12; 0, 94; 50, 12; 32, 42; -32, 42], style(color=0,
              rgbcolor={0,0,0})),
        Line(points=[-28, -92; -28, -20; 12, -20; 32, -30; 32, -86; 12, -94; -28,
              -94; -28, -92], style(color=0, rgbcolor={0,0,0}))),Documentation(info="<html>
<p>
This package provides models for interfacing real world models (i.e. process under control).
</p>
</html>"));

    model SampledADConverter "Idel AD-converter which works in a cyclic way."
      extends Controller.Interfaces.IADConverter;

      annotation(preferedView="info",Documentation(info="<html>
<p>
This model implements an ideal AD-converter which has cyclic behavior. Ideal means, that quantization effects are neglected.
Based on the given <i>samplingInterval</i>, the AD-converter reads in attached signals and stores them in the attached memory of type <a href=\"Controller.Memory.RAM\">RAM</a>.
For storing, the model uses the index of the input array as address in the memory. Input 1 is stored in address 1, input 2 is stored in address 2, etc.</p>
<p>
<b>Figure 1</b> shows the information of an AD-converter with five input signals.<br>
<br>
<img src=\"../doc/images/ADConverter.png\" width=\"500\"><br>
<br>
<b>Figure 1: Information flow of AD-conversion.</b><br>
<br>
The trigger cyclically starts the AD-conversion. The values read from the inputs are stored to the <a href=\"Controller.Memory.RAM\">RAM</a> using the function interface provided in <a href=\"Controller.Memory.Functions\">Controller.Memory.Functions</a>.
</p>
</html>"));
      //parameter variables
      parameter Modelica.SIunits.Time samplingInterval=1e-3
        "The sampling interval of the AD-Converter in s";
      parameter Boolean active=true
        "activate (true) or deactivate (false) AD-Converter";

      //protected variables
    protected
      Boolean sampleEvent;

    equation
      if (active) then
        sampleEvent = noEvent(sample(0, samplingInterval));
      else
        sampleEvent = false;
      end if;

      when (sampleEvent and time > 0) then
        for i in 1:n loop
          Controller.Memory.Functions.writeReal(
                PIInputs,
                i,
                analogInputs[i]);
        end for;
      end when;

      annotation (Diagram, Icon(Text(
            extent=[-100, 100; 100, 60],
            string="%name",
            style(
              color=0,
              rgbcolor={0,0,0},
              gradient=3,
              fillColor=10,
              rgbfillColor={95,95,95}))));
    end SampledADConverter;

    model SampledDAConverter "Ideal DA-converter which works in a cyclic way."
      extends Controller.Interfaces.IDAConverter;
      annotation(preferedView="info",Documentation(info="<html>
<p>
This model implements an ideal DA-converter which has cyclic behavior. Ideal means, that quantization effects are neglected.
Based on the given <i>samplingInterval</i>, the DA-converter reads desired output values from the attached memory of type <a href=\"Controller.Memory.RAM\">RAM</a> and writes the values to the output signals.
For reading desired values, the model uses the index of the output array as address in the memory. Output 1 is read from address 1, output 2 is read from address 2, etc.
</p>
<p>
<b>Figure 1</b> shows the information flow using a DA-converter with five outputs signals.<br>
<br>
<img src=\"../doc/images/DAConverter.png\" width=\"500\"><br>
<br>
<b>Figure 1: Information flow of DA-conversion.</b><br>
<br>
The trigger cyclically starts the DA-conversion. The values to be written to the outputs are read from the <a href=\"Controller.Memory.RAM\">RAM</a> using the function interface provided in <a href=\"Controller.Memory.Functions\">Controller.Memory.Functions</a>.
</p>
</html>"));
      //parameter variables
      parameter Modelica.SIunits.Time samplingInterval=1e-3
        "The sampling interval of the AD-Converter in s";
      parameter Boolean active=true
        "activate (true) or deactivate (false) AD-Converter";

      //protected variables
    protected
      Boolean sampleEvent;
    equation

      if (active) then
        sampleEvent = noEvent(sample(0, samplingInterval));
      else
        sampleEvent = false;
      end if;

      when (sampleEvent and time > 0) then
        for i in 1:n loop
          analogOutputs[i] = Controller.Memory.Functions.readReal(PIOutputs, i);
        end for;
      end when;
      annotation (Icon(Text(
            extent=[-100, -60; 100, -100],
            style(
              color=0,
              rgbcolor={0,0,0},
              pattern=0,
              gradient=3,
              fillColor=10,
              rgbfillColor={95,95,95}),
            string="DAC"), Text(
            extent=[-100, 100; 100, 60],
            string="%name",
            style(
              color=0,
              rgbcolor={0,0,0},
              gradient=3,
              fillColor=10,
              rgbfillColor={95,95,95}))), Diagram);
    end SampledDAConverter;
    annotation (Icon(Line(points=[0, 100; 0, -100], style(
            color=0,
            rgbcolor={0,0,0},
            pattern=2,
            thickness=4))));

  end ProcessInterface;

  package Memory "Package that contains models for storing information."

    annotation (preferedView="info",Documentation(info="<html>
<p>
This package provides models to store information in memories. Yet, only an implementation for a random access memory (<a href=\"RAM\">RAM</a>) is present.
</p>

</html>"));
    package Functions
      "Package that provides functions to read and write values from or to a RAM."

      package InterfaceFunctions
        "The wrapping functions to access the interface functions of the c implemented RAM model."
        function createRAM "Function to create a RAM."
          annotation (Include="#include <RAMManagerWrapper.h>",Library={
                "RAMManagerC++Wrapper","RAMManagerC++"});

          output Integer index "The unique index of the created RAM.";

        external "C" index = createRAM();

        end createRAM;

        function readRAM
          "Function to read a String value from a RAM at the given address."
          annotation (Include="#include <RAMManagerWrapper.h>",Library={
                "RAMManagerC++Wrapper","RAMManagerC++"});
          input Integer RAMIndex "The unique index of the RAM.";
          input Integer address "The address in the RAM to read from.";
          output String value "The value read from the RAM.";

        external "C" value = readRAM(RAMIndex, address);

        end readRAM;

        function writeRAM
          "Function to read a String value from a RAM at the given address."
          annotation (Include="#include <RAMManagerWrapper.h>",Library={
                "RAMManagerC++Wrapper","RAMManagerC++"});
          input Integer RAMIndex "The unique index of the RAM.";
          input Integer address "The address in the RAM to write to.";
          input String value "The String value to write to the RAM.";
          output Boolean success "Value indicating if writing was successful.";
        external "C" success = writeRAM(
                    RAMIndex,
                    address,
                    value);

        end writeRAM;

      end InterfaceFunctions;

      function readReal
        "Function to read a value of type Real from a RAM model."
        input Integer RAMIndex;
        input Integer address;
        output Real value;
      protected
        String stringvalue;
      algorithm
        stringvalue := InterfaceFunctions.readRAM(
          RAMIndex, address);

        if (stringvalue == "") then
          value := 0;
        else
          value := Modelica.Utilities.Strings.scanReal(stringvalue);
        end if;
      end readReal;

      function writeReal
        "Function to write a value of type Real to a RAM model."
        input Integer RAMIndex;
        input Integer address;
        input Real value;
        output Boolean success;
      protected
        String stringvalue;
      algorithm
        stringvalue := String(value);
        success := InterfaceFunctions.writeRAM(
                RAMIndex,
                address,
                stringvalue);
        //Modelica.Utilities.Streams.print("writeReal\t"+String(RAMIndex)+"\t"+String(address)+"\t"+stringvalue);

      end writeReal;

      function readBoolean
        "Function to read a value of type Boolean from a RAM model."
        input Integer RAMIndex "The ID of the RAM to read from.";
        input Integer address "The address in the RAM to read from.";
        output Boolean value "The Boolean value read from the RAM.";
      protected
        String stringvalue;
      algorithm
        stringvalue := InterfaceFunctions.readRAM(
          RAMIndex, address);

        if (stringvalue == "") then
          value := false;
        else
          if (stringvalue<>"0") then
            value := Modelica.Utilities.Strings.scanBoolean(stringvalue);
          else
            value:=false;
          end if;
        end if;
      end readBoolean;

      function writeBoolean
        "Function to read a value of type Boolean from a RAM model."
        input Integer RAMIndex "The ID of the RAM to write to.";
        input Integer address "The address in the RAM to write to.";
        input Boolean value "The Boolean value to write to the RAM.";
        output Boolean success;
      protected
        String stringvalue;
      algorithm
        stringvalue := String(value);
        success := InterfaceFunctions.writeRAM(RAMIndex,address,stringvalue);
      end writeBoolean;
    end Functions;

    model RAM
      "Interface model for a c implemented model of a random access memory (RAM)."
      extends Controller.Icons.Chip;

      annotation(preferedView="info",Documentation(info="<html>
<p>
This model is an interface model for an externally implemented random access memory (RAM), which is kept in an assembly of RAMs.
This model does not contain dynamics, it is only a placeholder for the unique index of the externally implemented RAM.
This unique index is published via the <a href=\"Controller.Interfaces.MemoryConnector\">MemoryConnector</a>.
</p>
<h3>Example</h3>
<p>
An example for the exchange of information between models using RAM is shown in the <a href=\"Controller.Examples.MemoryExample.AsynchronousMemoryAccess\">AsynchronousMemoryAccess</a> model.
</p>
<h3>Details</h3>
<p>
The correlation betwen Modelica and the externally provided RAM is shown in <b>Figure 1</b>.<br>
<br>
<img src=\"../doc/images/RAMInterface.png\" width=\"500\"><br>
<br>
<b>Figure 1: Interface to the externally implemented RAM.</b><br>
<br>
The external RAM is accessed via interface functions provided in the <a href=\"Functions.InterfaceFunctions\">Functions.InterfaceFunctions</a>.<br>
<ul>
  <li><a href=\"Functions.InterfaceFunctions.createRAM\">createRAM</a></li>
  <li><a href=\"Functions.InterfaceFunctions.readRAM\">readRAM</a></li>
  <li><a href=\"Functions.InterfaceFunctions.writeRAM\">writeRAM</a></li>
</ul>
</p>
<p>
In the initial simulation step, the Modelica RAM model automatically creates a RAM in the assembly of RAMs using the function <a href=\"Functions.InterfaceFunctions.createRAM\">createRAM</a> function, which return the unique index of the RAM in the assembly.
This index is then stored in the Modelica RAM model and published via the connector <a href=\"Controller.Interfaces.MemoryConnector\">memoryConnector</a> to other Modelica models.
</p>
<p>
To store values in the RAM, the library provides the <a href=\"Functions.InterfaceFunctions.writeRAM\">writeRAM</a> function.
For maximum flexibility the RAM stores strings which can be casted to other types. If values of type Real are used, the library offers the <a href=\"Functions.writeReal\">writeReal</a> function.
</p>
<p>
For reading values from the RAM, the library provides the <a href=\"Functions.InterfaceFunctions.readRAM\">readRAM</a> function, which operates on strings.
Also here, a function for values of type Real is covered by the library (<a href=\"Functions.readReal\">readReal</a>).
</p>

</html>"),     Icon);
      Controller.Interfaces.MemoryConnector RAMIndex
        annotation (extent=[-20,-80; 20,-40]);
    algorithm
      when (initial()) then
        Modelica.Utilities.Streams.print("RAM");
        RAMIndex := Controller.Memory.Functions.InterfaceFunctions.createRAM();
        Modelica.Utilities.Streams.print("RAMIndex: "+String(RAMIndex));
      end when;
      annotation (Diagram, Icon(Text(
            extent=[-100, -60; 100, -100],
            style(
              color=0,
              rgbcolor={0,0,0},
              pattern=0,
              gradient=3,
              fillColor=10,
              rgbfillColor={95,95,95}),
            string="RAM"), Text(
            extent=[-100, 100; 100, 60],
            string="%name",
            style(
              color=0,
              rgbcolor={0,0,0},
              gradient=3,
              fillColor=10,
              rgbfillColor={95,95,95}))));
    end RAM;

    annotation (Icon(
        Ellipse(extent=[-100, 100; 100, 60], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Ellipse(extent=[-100, -60; 100, -100], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-60, 30; -60, -30], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[10, 30; 10, -30], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[40, 30; 40, -30], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[10, 30; 40, 30], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[10, -30; 40, -30], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[-20, 30; -20, -30], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1)),
        Line(points=[68, 30; 68, -30], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255},
            fillPattern=1))));
  end Memory;

  package Examples
    "Package that contains subpackages which demonstrate how to use the library."

    annotation(preferedView="info",Documentation(info="<html>
<p>
This package is intended to provide examples on how to use the library.
</p>
<ul>
  <li>
    Package <a href=\"MemoryExample\">MemoryExample</a> shows how to exchange data a memory component (model <a href=\"Controller.Memory.RAM\">RAM</a>).
  </li>
  <li>

</ul>
</html>"));
    annotation(preferedView="info");

    package DelayExamples
      "Package that contains models to demonstrate reading and writing to a RAM."

      annotation(preferedView="info",Documentation(info="<html>
<p>
This package provides examples that explains how to share information between components using the <a href=\"Controller.Memory.RAM\">RAM</a> model and the ZigBee network.
</p>
<p>
To run the examples, simulate the <a href=\"PureSynchronisationEffects\">PureSynchronisationEffects</a> model or <a href=\"NetworkAndSynchronisationEffects\">NetworkAndSynchronisationEffects</a> model.
</html>"));

      model SimpleSensor "Model of a simple sensor operating in a cyclic way"

        annotation (Icon(
            Rectangle(extent=[-72,0; 72,-80], style(
                color=0,
                rgbcolor={0,0,0},
                arrow=1)),
            Text(
              extent=[-72,-20; 72,-60],
              style(
                color=0,
                rgbcolor={0,0,0},
                arrow=1),
              string="Sensor"),
            Text(
              extent=[-80,100; 80,20],
              string="%name",
              style(
                color=3,
                rgbcolor={0,0,255},
                arrow=1))), Diagram);
      annotation(preferedView="info",Documentation(info="<html>
<p>
This model implements a simple sensor, operating in cyclic way. Its behavior is quite simple. The model is driven by an internal clock which generates time events (<i>sampleEvent</i>).<br>
<br>
<pre>
  sampleEvent:=<font color=\"#ff0000\">sample</font>(0, samplingInterval);
</pre>
<br>
Each time the <i>sampleEvent</i> arises the current process signal is sensed (<i>sensedSignal</i>) and written to the attached RAM model (connector <i>memory</i>) at the given <i>address</i>.<br>
<br>
<pre>
  <font color=\"#006400\">//detect the sampleEvent</font>
  <font color=\"#0000ff\">when</font> (sampleEvent) <font color=\"#0000ff\">then</font>

    <font color=\"#006400\">//read the current value from the process</font>
    sensedSignal:=u;

    <font color=\"#006400\">//write a Boolean value to the RAM model with ID memory to position address</font>
    <font color=\"#ff0000\">readBoolean</font>(memory,address,sensedSignal);

  <font color=\"#0000ff\">end when</font>;
</pre>
</p>
</html>"));

        import Controller.Memory.Functions.*;
        //section with parameters
        parameter Integer address=1
          "Address in the memory to write sensor value to.";
        parameter Modelica.SIunits.Time samplingInterval=0.01
          "Interval of the sensor sensing the input u. Must be larger than 0.";
        Interfaces.MemoryConnector memory "ID of the attached RAM model"
                                          annotation (extent=[60,-60; 100,-20]);
        Modelica.Blocks.Interfaces.BooleanInput u "Observed process signal"
          annotation (extent=[-100,-60; -60,-20]);

        Boolean sensedSignal(start=false)
          "The value of the signal sensed last time";
      protected
        Boolean sampleEvent
          "Event internally generated to read the input value from process and write it to the RAM";

      algorithm
        sampleEvent:=sample(0, samplingInterval);

        //detect the sampleEvent
        when (sampleEvent) then

          //read the current value from the process
          sensedSignal:=u;

          //write a Boolean value to the RAM model with ID memory to position address
          writeBoolean(memory,address,u);
        end when;

      end SimpleSensor;

      model SimpleActuator
        "Model of a simple actuator operating in a cyclic way."

        annotation(preferedView="info",Documentation(info="<html>
<p>
This model implements a simple actuator, operating in cyclic way. Its behavior is quite simple. The model is driven by an internal clock which generates time events (<i>sampleEvent</i>).<br>
<br>
<pre>
  sampleEvent:=<font color=\"#ff0000\">sample</font>(0, samplingInterval);
</pre>
<br>
Each time the <i>sampleEvent</i> arises a new set value (<i>appliedSignal</i>) is read from the attached RAM model (connector <i>memory</i>) at the given <i>address</i>. Afterwards the new set value is applied to the process.<br>
<br>
<pre>
  <font color=\"#006400\">//detect the sampleEvent</font>
  <font color=\"#0000ff\">when</font> (sampleEvent) <font color=\"#0000ff\">then</font>

    <font color=\"#006400\">//read a Boolean value from the RAM model with ID memory from position address</font>
    appliedSignal:=<font color=\"#ff0000\">readBoolean</font>(memory,address);

    <font color=\"#006400\">//apply the new set value to the process</font>
    y:=apliedSignal;
  <font color=\"#0000ff\">end when</font>;
</pre>
</p>
</html>"),Diagram);

        import Controller.Memory.Functions.*;

        //Parameter section
        parameter Integer address=1
          "Address in the memory to write sensor value to.";
        parameter Modelica.SIunits.Time samplingInterval=0.011
          "Interval of the sensor sensing the input u. Must be larger than 0.";

        Interfaces.MemoryConnector memory "ID of the attached RAM"
                                          annotation (extent=[-100,-60; -60,-20]);
        Modelica.Blocks.Interfaces.BooleanOutput y
          annotation (extent=[60,-60; 100,-20]);

        Boolean appliedSignal(start=false)
          "The value of the signal applied last time";

      protected
        Boolean sampleEvent(start=false)
          "Event internally generated to read the set value from the RAM and write it to the output y.";
      algorithm

        sampleEvent:=sample(0, samplingInterval);

        //detect the sampleEvent
        when (sampleEvent) then

          //read a Boolean value from the RAM model with ID memory from position address
          appliedSignal:=readBoolean(memory,address);

          //apply the new set value to the process
          y:=appliedSignal;
        end when;

        annotation (Icon(
            Rectangle(extent=[-72,0; 72,-80], style(
                color=0,
                rgbcolor={0,0,0},
                arrow=1)),
            Text(
              extent=[-72,-20; 72,-60],
              style(
                color=0,
                rgbcolor={0,0,0},
                arrow=1),
              string="Actuator"),
            Text(
              extent=[-80,100; 80,20],
              string="%name",
              style(
                color=3,
                rgbcolor={0,0,255},
                arrow=1))));
      end SimpleActuator;

      model Stopwatch
        "Model to determine the delay between two events on two distinctive inputs"

      package StopwatchState
        extends Modelica.Icons.Enumeration;

        constant Integer Stopped=1;
        constant Integer Running=2;
        type Temp
          extends Modelica.Icons.TypeInteger;
        end Temp;
      end StopwatchState;

        import Modelica.SIunits.*;
        Modelica.Blocks.Interfaces.RealOutput delay(redeclare type SignalType
            = Modelica.SIunits.Time)
          "Delay between the occurance of the start and the stop event."
                                                annotation (extent=[40,-50; 60,
              -30]);
        Modelica.Blocks.Interfaces.BooleanInput start
          "Event to start the measurement"
          annotation (extent=[-80,-20; -40,20]);
        Modelica.Blocks.Interfaces.BooleanInput stop
          "Event to stop the measurment."
          annotation (extent=[-80,-80; -40,-40]);
        annotation (Diagram, Icon(
            Ellipse(extent=[-40,14; 40,-66], style(
                color=3,
                rgbcolor={0,0,255},
                arrow=1)),
            Polygon(points=[16,12; 22,14; 28,10; 26,4; 16,12],  style(
                color=3,
                rgbcolor={0,0,255},
                arrow=1,
                fillColor=1,
                rgbfillColor={255,0,0})),
            Polygon(points=[-10,14; -6,22; 4,22; 8,14; -10,14],  style(
                color=3,
                rgbcolor={0,0,255},
                arrow=1,
                fillColor=2,
                rgbfillColor={0,255,0})),
            Line(points=[0,-26; 0,4],style(
                color=3,
                rgbcolor={0,0,255},
                thickness=4,
                arrow=1,
                fillColor=3,
                rgbfillColor={0,0,255},
                fillPattern=1)),
            Line(points=[0,-26; 20,8],style(
                color=3,
                rgbcolor={0,0,255},
                thickness=4,
                arrow=1,
                fillColor=3,
                rgbfillColor={0,0,255},
                fillPattern=1)),
            Text(
              extent=[-20,40; 20,20],
              string="start",
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=4,
                arrow=1,
                fillColor=3,
                rgbfillColor={0,0,255},
                fillPattern=1)),
            Text(
              extent=[20,30; 60,10],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=4,
                arrow=1,
                fillColor=3,
                rgbfillColor={0,0,255},
                fillPattern=1),
              string="stop"),
            Text(
              extent=[-100,40; -40,20],
              string="start",
              style(
                color=87,
                rgbcolor={255,85,170},
                thickness=2,
                fillPattern=1)),
            Text(
              extent=[-100,-80; -40,-100],
              string="stop",
              style(
                color=87,
                rgbcolor={255,85,170},
                thickness=2,
                fillPattern=1)),
            Text(
              extent=[-100,100; 100,40],
              style(color=3, rgbcolor={0,0,255}),
              string="%name")));

        StopwatchState.Temp state(start=StopwatchState.Stopped)
          "Internal state of the model";

        Time startTime "Time instance when start event arised";
        Modelica.Blocks.Interfaces.BooleanOutput done
          "Event that is raised when a measurement is finished"
          annotation (extent=[40,-20; 60,0]);
      algorithm

        done:=false;

        //Detect the start event
        when (state==StopwatchState.Stopped and start and not stop) then
          state:=StopwatchState.Running;

          //store time instance of start event
          startTime:=time;
        elsewhen
                (state==StopwatchState.Running and stop) then
          state:=StopwatchState.Stopped;

          delay:=(time-startTime);

          //Raise the done event
          done:=true;
        end when;

      end Stopwatch;

      model RandomEventSource
        "Model that periodically generates evenly distributed events in predefined time bounds"

        annotation (Icon(
            Line(points=[-48,20; -48,-72], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                arrow=2,
                fillColor=0,
                rgbfillColor={0,0,0})),
            Line(points=[72,-52; -68,-52], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                arrow=2,
                fillColor=0,
                rgbfillColor={0,0,0})),
            Rectangle(extent=[-8,-12; 52,-52], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                arrow=2)),
            Text(
              extent=[-28,-60; 12,-80],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                arrow=2,
                fillPattern=1),
              string="min"),
            Text(
              extent=[32,-60; 72,-80],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                arrow=2,
                fillPattern=1),
              string="max"),
            Line(points=[-54,-12; -48,-12], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
            Line(points=[-8,-52; -8,-56], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
            Line(points=[52,-52; 52,-56], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1)),
            Text(
              extent=[-62,46; -32,16],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1),
              string="p(T)"),
            Text(
              extent=[72,-40; 92,-60],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1),
              string="T"),
            Text(
              extent=[-94,0; -54,-20],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1),
              string="1/(max-min)"),
            Text(
              extent=[-100,100; 100,40],
              string="%name",
              style(
                color=3,
                rgbcolor={0,0,255},
                thickness=2,
                fillPattern=1))), Diagram);

      package RandomEventSourceState
        extends Modelica.Icons.Enumeration;

        constant Integer Waiting=1;
        constant Integer PublishingEvent=2;
        type Temp
          extends Modelica.Icons.TypeInteger;
        end Temp;
      end RandomEventSourceState;

        Modelica.Blocks.Interfaces.BooleanOutput event "Generated event"
          annotation (extent=[80,-30; 100,-10]);

        import Modelica.SIunits.*;

        parameter Period minT=0.05 "Minimum time span between two events";
        parameter Period maxT=0.1 "Maximum time span between two events";
        parameter Period deltaT=0.03 "Length of signal value when event arises";

        RandomEventSourceState.Temp state( start=RandomEventSourceState.Waiting)
          "Internal state of the model";
      protected
        Time eventTime( start=minT) "Time enstance when next event arises";
        Time eventPublishingEnd( start=maxT)
          "Time instance when event publishing is done";

      initial algorithm
        eventTime:=minT + RandomUniform(time)*(maxT - minT);

      algorithm
        assert(deltaT<minT,"Length of signal must be shorter than minimum time span!");

        when (time>eventTime) then
          //calculation of next time occurance
          eventTime:=time+minT + RandomUniform(time)*(maxT - minT);

          //time instance when signal value is reset to false
          eventPublishingEnd:=time+deltaT;

          state:=RandomEventSourceState.PublishingEvent;
        elsewhen
                (time>eventPublishingEnd) then

          state:=RandomEventSourceState.Waiting;
        end when;

        if (state==RandomEventSourceState.PublishingEvent) then
          event:=true;
        else
          event:=false;
        end if;
      end RandomEventSource;

      model DelayTimeFileWriter
        "This model writes the measured delay time to a file."
        annotation (Diagram, Icon(
            Rectangle(extent=[-72,0; 72,-80], style(
                color=0,
                rgbcolor={0,0,0},
                arrow=1)),
            Text(
              extent=[-72,-20; 72,-60],
              style(
                color=0,
                rgbcolor={0,0,0},
                arrow=1),
              string="FileWriter"),
            Text(
              extent=[-100,100; 100,20],
              string="%name",
              style(
                color=3,
                rgbcolor={0,0,255},
                thickness=2,
                fillPattern=1)),
            Text(
              extent=[-72,-56; 72,-80],
              string="%filename",
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=2,
                fillPattern=1))));

        function writeDelayToFile
          "Function to write the measured delay to the given file"

          import Modelica.Utilities.Streams.*;
          annotation (preferedView="info", Documentation(info="<html>
<p>
This function writes the measured delay to a file in tab-stop-format. Each line in the file has the following format:<br>
<br>
<br>
<table border=\"1\">
   <tr bgcolor=\"#aaaaaa\"><td >simulation time</td><td>'\\t'</td><td>delay</td><td>'\\n'</td><tr>
</table>
<br>
<br>
where <i>simulation time</i> and <i>delay</i> have the unit s.
</p>
</html>"));
          input String filename "The filename of the file to write to";
          input Modelica.SIunits.Time simulationTime
            "The simulation time when this function was called";
          input Modelica.SIunits.Time delay
            "The delay value to write to the file";
        algorithm
          print(String(simulationTime)+"\t"+String(delay),filename);
          close(filename);
        end writeDelayToFile;
        Modelica.Blocks.Interfaces.RealInput delay(redeclare type SignalType =
              Modelica.SIunits.Time) annotation (extent=[-112,-80; -72,-40]);
        Modelica.Blocks.Interfaces.BooleanInput writeEvent
          annotation (extent=[-112,-40; -72,0]);

        parameter String filename="delayTime.txt" "The file to write to.";

      algorithm
        when (initial()) then
          Modelica.Utilities.Files.removeFile(filename);
        elsewhen (writeEvent) then
          writeDelayToFile(filename,time,delay);
        end when;

      end DelayTimeFileWriter;

      model PureSynchronisationEffects
        "Experiment to retrieve the response time in a distributed control system"
        extends Modelica.Icons.Example;

        annotation (preferedView="info",Documentation(info="<html>
<p>
This model is an application example of the Controller library.
It shows how to determine the reaction time of a distributed control system with a sensor and an actuator communicating via a shared memory (model <a href=\"Controller.Memory.RAM\">RAM</a>).
</p>
<h2>Model description</h2>
<p>
<b>Figure 1</b> shows the Diagram layer of the Model.<br>
<br>
<img src=\"../doc/images/DelayExperiment.png\" width=\"700\"><br>
<br>
<b>Figure 1: Diagram layer of the Model.</b><br>
<br>
The component <a href=\"RandomEventSource\">randomEventSource</a> periodically generates events (0.5s &lt; T &lt; 1s). An event is published as a 100 ms true level on the event connector.
The component <a href=\"SimpleSensor\">simpleSensor</a> senses its boolean input cyclically (10 ms cylce time) and writes the read Boolean value to the memory component <a href=\"Controller.Memory.RAM\">ram</a>.
The component <a href=\"SimpleActuator\">simpleActuator</a> cyclically (11 ms cycle time) reads the set value from the ram and applies this value to its output signal.
At the same time, the component <a href=\"Stopwatch\">stopwatch</a> measures the delay betweent the occurence of the event at the sensor entrance and the reaction to the event on the actuator output.
</p>
<p>
To simplify analysis of retrieved simulation data, the <a href=\"DelayTimeFileWriter\">delayTimeFileWriter</a> component stores the response time for each event in a the file <i>delayTime.txt</i> in a tab-stop-format.
</p>
<h2>Application example</h2>
<p>
A real world example for this experiment is the determination of the reaction of a distributed control system to an emergency stop signal, where delays on the network and the execution time of the logic controller algorithm can be neglected.
</p>
<p>
The analysed result of this experiment with 1000 s simulated time, reveals the distribution of the reaction time as shown in Figure 2.<br>
<br>
<img src=\"../doc/images/DelayDistribution.png\" width=\"700\"><br>
<br>
<b>Figure 2: Response time distribution of a distributed control system with network and control law delays neglected.</b><br>
<br>
The minimum reponse time measured was 1.0042 ms, the maximum response time measured was 20.9939 ms. These values are quite near to the theoretical values of 1 ms and 21 ms. Ideally, the reponse time distribution would be an triangle.
</p>

</html>"),experiment(StopTime=1000),
          experimentSetupOutput);

        SimpleSensor simpleSensor annotation (extent=[-30,14; -10,34]);
        SimpleActuator simpleActuator annotation (extent=[50,14; 70,34]);
        Memory.RAM ram annotation (extent=[10,20; 30,40]);
        RandomEventSource randomEventSource annotation (extent=[-100,-20; -40,40]);
        Stopwatch stopwatch annotation (extent=[-20,-48; 20,-8], rotation=0);
        DelayTimeFileWriter delayTimeFileWriter annotation (extent=[22,-40; 62,0]);
      equation

        annotation (Diagram);
        connect(simpleSensor.memory, ram.RAMIndex) annotation (points=[-12,20; 20,20],
            style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            fillColor=3,
            rgbfillColor={0,0,255},
            fillPattern=1));
        connect(ram.RAMIndex, simpleActuator.memory) annotation (points=[20,20; 52,20],
            style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            fillColor=3,
            rgbfillColor={0,0,255},
            fillPattern=1));
        connect(simpleActuator.y, stopwatch.stop) annotation (points=[68,20; 80,20;
              80,-60; -20,-60; -20,-40; -12,-40], style(
            color=5,
            rgbcolor={255,0,255},
            thickness=2,
            fillPattern=1));
        connect(randomEventSource.event, simpleSensor.u) annotation (points=[-43,4;
              -38,4; -38,20; -28,20], style(
            color=5,
            rgbcolor={255,0,255},
            thickness=2,
            fillPattern=1));
        connect(stopwatch.start, randomEventSource.event) annotation (points=[-12,-28;
              -38,-28; -38,4; -43,4], style(
            color=5,
            rgbcolor={255,0,255},
            thickness=2,
            fillPattern=1));
        connect(stopwatch.done, delayTimeFileWriter.writeEvent) annotation (points=[10,-30;
              16.8,-30; 16.8,-24; 23.6,-24],
                                 style(
            color=5,
            rgbcolor={255,0,255},
            thickness=2,
            fillPattern=1));
        connect(stopwatch.delay, delayTimeFileWriter.delay) annotation (points=[10,-36;
              16.8,-36; 16.8,-32; 23.6,-32],
                              style(
            color=74,
            rgbcolor={0,0,127},
            thickness=2,
            fillPattern=1));
      end PureSynchronisationEffects;

      model SimpleNetworkSensor
        "Model of a simple sensor operating in a cyclic way"
        import
          Network.PrimaryController.ProtocolFunctions.SingleValueDataProtocol.*;
        import Network.Cache.CacheFunctions.*;
        import Network.*;

        annotation (Icon(
            Rectangle(extent=[-72,0; 72,-80], style(
                color=0,
                rgbcolor={0,0,0},
                arrow=1)),
            Text(
              extent=[-72,-20; 72,-60],
              style(
                color=0,
                rgbcolor={0,0,0},
                arrow=1),
              string="Sensor"),
            Text(
              extent=[-80,100; 80,20],
              string="%name",
              style(
                color=3,
                rgbcolor={0,0,255},
                arrow=1))), Diagram);
      annotation(preferedView="info",Documentation(info="<html>
<p>
This model implements a simple sensor, operating in cyclic way. Its behavior is quite simple. The model is driven by an internal clock which generates time events (<i>sampleEvent</i>).<br>
<br>
<pre>
  sampleEvent:=<font color=\"#ff0000\">sample</font>(0, samplingInterval);
</pre>
<br>
Each time the <i>sampleEvent</i> arises the current process signal is sensed (<i>sensedSignal</i>) and written to the attached RAM model (connector <i>memory</i>) at the given <i>address</i>.<br>
<br>
<pre>
  <font color=\"#006400\">//detect the sampleEvent</font>
  <font color=\"#0000ff\">when</font> (sampleEvent) <font color=\"#0000ff\">then</font>

    <font color=\"#006400\">//read the current value from the process</font>
    sensedSignal:=u;

    <font color=\"#006400\">//write a Boolean value to the RAM model with ID memory to position address</font>
    <font color=\"#ff0000\">readBoolean</font>(memory,address,sensedSignal);

  <font color=\"#0000ff\">end when</font>;
</pre>
</p>
</html>"));

        //section with parameters
        parameter Integer destinationAddress=2
          "Network Address of destination node";
        parameter Modelica.SIunits.Time samplingInterval=0.011
          "Interval of the sensor sensing the input u. Must be larger than 0.";
        Modelica.Blocks.Interfaces.BooleanInput u "Observed process signal"
          annotation (extent=[-100,-60; -60,-20]);

        Boolean sensedSignal(start=false)
          "The value of the signal sensed last time";
        Real valueToActuator "The value sent to the actuator via network";
      protected
        Integer sendCacheID=transceiver.cacheBusConnector.sendCacheID;
        Integer messageID;
        Boolean sampleEvent
          "Event internally generated to read the input value from process and write it to the RAM";

      public
        Network.Interfaces.ICConnector transceiver
          annotation (extent=[60,-60; 100,-20]);
      algorithm
        sampleEvent:=sample(0, samplingInterval);

        //detect the sampleEvent
        when (sampleEvent and time >0) then

          //read the current value from the process
          sensedSignal:=u;

          //Convert Boolean to Real value
          valueToActuator:=if (sensedSignal) then 1 else 0;

          //enqueue a message in the transceiver
          //1. step: create the message itself
          messageID:=createSendMessage(destinationAddress,Network.OperationType.UpdateActuatorValue,
                                                                                             valueToActuator);

          //2. step: enqueue the message in the send queue of the transceiver
          Network.Cache.CacheFunctions.enqueue(
                  sendCacheID,messageID);

        end when;

      end SimpleNetworkSensor;

      model SimpleNetworkActuator
        "Model of a simple actuator operating in a cyclic way."

        annotation(preferedView="text",Documentation(info="<html>
<p>
This model implements a simple actuator, operating in cyclic way. Its behavior is quite simple. The model is driven by an internal clock which generates time events (<i>sampleEvent</i>).<br>
<br>
<pre>
  sampleEvent:=<font color=\"#ff0000\">sample</font>(0, samplingInterval);
</pre>
<br>
Each time the <i>sampleEvent</i> arises a new set value (<i>appliedSignal</i>) is read from the attached RAM model (connector <i>memory</i>) at the given <i>address</i>. Afterwards the new set value is applied to the process.<br>
<br>
<pre>
  <font color=\"#006400\">//detect the sampleEvent</font>
  <font color=\"#0000ff\">when</font> (sampleEvent) <font color=\"#0000ff\">then</font>

    <font color=\"#006400\">//read a Boolean value from the RAM model with ID memory from position address</font>
    appliedSignal:=<font color=\"#ff0000\">readBoolean</font>(memory,address);

    <font color=\"#006400\">//apply the new set value to the process</font>
    y:=apliedSignal;
  <font color=\"#0000ff\">end when</font>;
</pre>
</p>
</html>"),Diagram);

        import
          Network.PrimaryController.ProtocolFunctions.SingleValueDataProtocol.*;
        import Network.Cache.CacheFunctions.*;
        import Network.*;

        //Parameter section
        parameter Modelica.SIunits.Time samplingInterval=0.010
          "Interval of the sensor sensing the input u. Must be larger than 0.";

        Network.Interfaces.ICConnector transceiver "ID of the attached RAM"
                                          annotation (extent=[-100,-60; -60,-20]);
        Modelica.Blocks.Interfaces.BooleanOutput y
          annotation (extent=[60,-60; 100,-20]);

        Boolean appliedSignal(start=false)
          "The value of the signal applied last time";
        Real valueFromSensor "The value received via network";
        Network.OperationType.Temp operationType
          "The operation type specified in the network message";
        Integer sourceAddress "The network address of the source node";

        Integer messageID "The identifier of the dequeued message";
      protected
        Boolean sampleEvent(start=false)
          "Event internally generated to read the set value from the RAM and write it to the output y.";
        Integer receiveCacheID=transceiver.cacheBusConnector.rcvCacheID
          "The identifier of the receive cache of the transceiver";

      algorithm
        sampleEvent:=sample(0, samplingInterval);

        //detect the sampleEvent
        when (sampleEvent and time >0) then

          //check if receive of transceiver contains a message
          if (Network.Cache.CacheFunctions.cacheNotEmpty(
                            receiveCacheID)) then

              //Dequeue message from receive queue in transceiver
              messageID:=Network.Cache.CacheFunctions.dequeue(
                                 receiveCacheID);

              //interpret received message, here the SingleValueDataProtocol is used
              (sourceAddress,operationType,valueFromSensor):=getReceiveMessage(messageID);

              //Convert received real value to boolean value
              appliedSignal:=if (valueFromSensor > 0.5) then true else false;

          end if;

          //apply the new set value to the process
          y:=appliedSignal;
        end when;

        annotation (Icon(
            Rectangle(extent=[-72,0; 72,-80], style(
                color=0,
                rgbcolor={0,0,0},
                arrow=1)),
            Text(
              extent=[-72,-20; 72,-60],
              style(
                color=0,
                rgbcolor={0,0,0},
                arrow=1),
              string="Actuator"),
            Text(
              extent=[-80,100; 80,20],
              string="%name",
              style(
                color=3,
                rgbcolor={0,0,255},
                arrow=1))));
      end SimpleNetworkActuator;

      model NetworkAndSynchronisationEffects
        "Experiment to retrieve the response time in a distributed control system when nodes communicate via a ZigBee network"
        extends Modelica.Icons.Example;

        annotation (preferedView="info",Documentation(info="<html>
<p>
This model is an application example of the Controller library.
It shows how to determine the reaction time of a distributed control system with a sensor and an actuator communicating via a ZigBee network (<a href=\"Network.ZigBee\">ZigBee</a>).
</p>
<h2>Model description</h2>
<p>
<b>Figure 1</b> shows the Diagram layer of the Model.<br>
<br>
<img src=\"../doc/images/NetworkDelayExperiment.png\" width=\"700\"><br>
<br>
<b>Figure 1: Diagram layer of the Model.</b><br>
<br>
The component <a href=\"RandomEventSource\">randomEventSource</a> periodically generates events (0.5s &lt; T &lt; 1s). An event is published as a 100 ms true level on the event connector.
The component <a href=\"SimpleNetworkSensor\">simpleNetworkSensor</a> senses its boolean input cyclically (11 ms cylce time) and enqueues the read Boolean value to the attached transceiver component <a href=\"Network.ZigBee.ZigBee_transceivermodul\">Zigbee_transceivermodul</a>.
The component <a href=\"SimpleActuator\">simpleNetworkActuator</a> cyclically (10 ms cycle time) checks if a network message has arrived via the attached transceiver component. If a message has arrived, the received message is interpreted and the extracted set value is applied to the output.
At the same time, the component <a href=\"Stopwatch\">stopwatch</a> measures the delay betweent the occurence of the event at the sensor entrance and the reaction to the event on the actuator output.
</p>
<p>
To simplify analysis of retrieved simulation data, the <a href=\"DelayTimeFileWriter\">delayTimeFileWriter</a> component stores the response time for each event in a the file <i>delayTime.txt</i> in a tab-stop-format.
</p>
<h2>Application example</h2>
<p>
A real world example for this experiment is the determination of the reaction of a distributed control system to an emergency stop signal, where the execution time of the logic controller algorithm can be neglected.
</p>
<p>
The analysed result of this experiment with 1000 s simulated time, reveals the distribution of the reaction time as shown in Figure 2.<br>
<br>
<img src=\"../doc/images/RelativeFrequencyDistributionNetworkDelay.png\" width=\"700\"><br>
<br>
<b>Figure 2: Response time distribution of a distributed control system with network and control law delays neglected.</b><br>
<br>
The minimum reponse time measured was 2.228 ms, the maximum response time measured was 23.982 ms.
</p>

</html>"),experiment(StopTime=10),
          experimentSetupOutput,
          Diagram);

        RandomEventSource randomEventSource annotation (extent=[-100,-20; -40,40]);
        Stopwatch stopwatch annotation (extent=[-20,-48; 20,-8], rotation=0);
        DelayTimeFileWriter delayTimeFileWriter annotation (extent=[22,-40; 62,0]);
        SimpleNetworkSensor simpleNetworkSensor(destinationAddress=2)
          annotation (extent=[-28,20; -8,40]);
        Network.ZigBee.ZigBeeSharedMedium zigBeesharedmedium
          annotation (extent=[10,70; 30,90]);
        Network.ZigBee.ZigbeeTransceivermodul zigbeetransceivermodul(sourceAddress=1)
          annotation (extent=[-6,40; 14,60]);
        Network.ZigBee.ZigbeeTransceivermodul zigbeetransceivermodul1(sourceAddress=2)
          annotation (extent=[32,40; 52,60]);
        SimpleNetworkActuator simpleNetworkActuator annotation (extent=[46,20; 66,40]);
      equation

        annotation (Diagram);
        connect(stopwatch.start,randomEventSource. event) annotation (points=[-12,-28;
              -38,-28; -38,4; -43,4], style(
            color=5,
            rgbcolor={255,0,255},
            thickness=2,
            fillPattern=1));
        connect(stopwatch.done,delayTimeFileWriter. writeEvent) annotation (points=[10,-30;
              16.8,-30; 16.8,-24; 23.6,-24],
                                 style(
            color=5,
            rgbcolor={255,0,255},
            thickness=2,
            fillPattern=1));
        connect(stopwatch.delay,delayTimeFileWriter. delay) annotation (points=[10,-36;
              16.8,-36; 16.8,-32; 23.6,-32],
                              style(
            color=74,
            rgbcolor={0,0,127},
            thickness=2,
            fillPattern=1));
        connect(randomEventSource.event, simpleNetworkSensor.u) annotation (points=[
              -43,4; -38,4; -38,26; -26,26], style(
            color=5,
            rgbcolor={255,0,255},
            thickness=2));
        connect(simpleNetworkSensor.transceiver, zigbeetransceivermodul.iCConnector)
          annotation (points=[-10,26; -10,42.3; -0.8,42.3], style(
            color=2,
            rgbcolor={0,255,0},
            thickness=2));
        connect(zigbeetransceivermodul.networkPort, zigBeesharedmedium.networkPort[
          1]) annotation (points=[9.2,58.3; 9.2,80; 20,80; 19.9,80.1],         style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(zigbeetransceivermodul1.networkPort, zigBeesharedmedium.networkPort[
          2]) annotation (points=[47.2,58.3; 47.6,58.3; 47.6,80.1; 19.9,80.1], style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(zigbeetransceivermodul1.iCConnector, simpleNetworkActuator.transceiver)
          annotation (points=[37.2,42.3; 37.2,34.15; 48,34.15; 48,26], style(
            color=2,
            rgbcolor={0,255,0},
            thickness=2));
        connect(simpleNetworkActuator.y, stopwatch.stop) annotation (points=[64,26;
              70,26; 70,-56; -20,-56; -20,-40; -12,-40], style(
            color=5,
            rgbcolor={255,0,255},
            thickness=2));
      end NetworkAndSynchronisationEffects;
    end DelayExamples;

    package PLCPIDController
      "Package that contains and example for a classical control system with a PLC compared to an ideal analog controller."
      annotation(preferedView="info");

      model PLCTask "Controller for an inverted pendulum"
        extends CPU.Task.Task;

      package PLCTaskState
        extends Modelica.Icons.Enumeration;

        constant Integer readInputs= 1
            "read values from the process image of inputs";
        constant Integer executeControlLaw= 2 "execute the control law";
        constant Integer writeOutput= 3
            "write control value to the process image of outputs";

        type Temp
            "special type which is necessary to emulate an enumeration in Dymola."
          extends Modelica.Icons.TypeInteger;
        end Temp;
      end PLCTaskState;

        annotation(preferedView="info",Documentation(info="<html>

<p>
This task implements a state feedback controller using a three step state machine as shown in the following figure.
</p>
<p>
  <img src=\"../doc/images/PIDTaskStateMachine.png\">
</p>
<p>
  <ul>
    <li>
      <b>read inputs</b>. In the initial step, the input signals are read from the process image of inputs:<br>
      <br>
      <pre>
x:=<font color=\"#ff0000\">Controller.Memory.Functions.readReal</font>(PIInputs, 1);
v:=<font color=\"#ff0000\">Controller.Memory.Functions.readReal</font>(PIInputs, 2);
phi:=<font color=\"#ff0000\">Controller.Memory.Functions.readReal</font>(PIInputs,3);
omega:=<font color=\"#ff0000\">Controller.Memory.Functions.readReal</font>(PIInputs,4);
      </pre>
    </li>
    <li>
      <b>ececute control law</b>. The subsequent step implements all commands reffering to the control law:<br>
      <br>
      <pre>
F := kx*x + kv*v + kphi*phi + komega*omega;
      </pre>
    </li>
    <li>
      <b>write output value</b>. In the last step the calculated control value is written to the process image of outputs:<br>
      <br>
      <pre>
<font color=\"#ff0000\">Controller.Memory.Functions.writeReal</font>(PIOutputs,1,F);
      </pre>
      <br>
      where <i>F</i> is the control value which is stored in position 1 of the process image of outputs.
    </li>
  </ul>
</p>

<p>
To implement the state machine the following pattern is used:
  <ul>
    <li>
      The tasks to be done in a state should be executed when the jobFinished event arises. To do so, the implementation of the state machine is wrapped in when-construct with <i>pre(jobFinished)</i> as condition:<br>
      <br>
      <code>
        <font color=\"#0000ff\">when</font>(<font color=\"#ff0000\">pre</font>(jobFinished)) <font color=\"#0000ff\">then</font><br>
          <font color=\"#006400\">//Implementation of the state machine</font><br>
        <font color=\"#0000ff\">end when</font>;<br>
      </code>
      <br>
      The condition event <i>jobFinished</i> must be wrapped by a <i>pre</i> to brake the algebraic loop between the task model and the scheduler model.
    </li><br>
    <br>
    <li>
      The information about the active state is kept in an enumeration variable of type <a href=\"PLCTaskState\">PLCTaskState</a> called <i>mode</i>.
    </li><br>
    <br>
    <li>
      The commands to be execute in a state are encoded as an if-then-elseif construct with the mode as the condition:<br>
      <br>
      <code>
        ...<br>
        <font color=\"#0000ff\">if</font> (mode==PLCTaskState.readInputs) <font color=\"#0000ff\">then</font><br>
          ...<br>
        <font color=\"#0000ff\">elseif</font> (mode==PLCTaskState.executeControlLaw) <font color=\"#0000ff\">then</font><br>
          ...<br>
        <font color=\"#0000ff\">elseif</font> (mode==PLCTaskState.writeOutputs) <font color=\"#0000ff\">then</font><br>
          ...<br>
        <font color=\"#0000ff\">end if</font>;<br>
        ...
      </code>
      <br>
    </li>
    <br>
    <li>
      State transition is encoded at the end of a block in the if-then-elseif construct, together with the definition of the runTime (in terms of processing cycles) for the next state:<br>
      <br>
      <code>
        ...<br>
        <font color=\"#0000ff\">if</font> (mode==PLCTaskState.readInputs) <font color=\"#0000ff\">then</font><br>
        &nbsp;&nbsp;<font color=\"#006400\">//commands in state <i>read inputs</i></font><br>
        &nbsp;&nbsp;...
        <br>
        &nbsp;&nbsp;<font color=\"#006400\">//determine next state</font><br>
        &nbsp;&nbsp;mode=PLCTaskState.executeControlLaw;<br>
        <br>
        &nbsp;&nbsp;<font color=\"#006400\">//define runTime in next state</font><br>
        &nbsp;&nbsp;runTime:=controlLawCycles/CPUFreq;<br>
        <br>
        <font color=\"#0000ff\">elseif</font> (mode==PLCTaskState.executeControlLaw) <font color=\"#0000ff\">then</font><br>
        ...
      </code>
    <li>
  </ul>
</p>
</html>"));
        parameter Real kx=-0.1;
        parameter Real kv=-0.3;
        parameter Real kphi=-13.6;
        parameter Real komega=-2.3;
        parameter Integer readCycles=500
          "number of processor cycles to read the inputs";
        parameter Integer controlLawCycles=1000
          "number of processor cycles to execute the control law";
        parameter Integer writeCycles=100
          "number of processor cycles to write the outputs";

        parameter Integer actuatorOutput=1;
        PLCTaskState.Temp mode(start=PLCTaskState.readInputs);

        Modelica.SIunits.Force F(start=0);
        Modelica.SIunits.Position x(start=0);
        Modelica.SIunits.Velocity v(start=0);
        Modelica.SIunits.Angle phi(start=0);
        Modelica.SIunits.AngularVelocity omega(start=0);

      initial algorithm
        runTime := readCycles/CPUFreq;
      algorithm
        sleepTime:=0;
        idle:=false;
        when (pre(jobFinished)) then
          Modelica.Utilities.Streams.print("Time: "+String(time));
          reinit(runTimer,0);

          if (mode==PLCTaskState.readInputs) then

            //read input sensor value from process image
            x:=Controller.Memory.Functions.readReal(PIInputs, 1);
            v:=Controller.Memory.Functions.readReal(PIInputs, 2);
            phi:=Controller.Memory.Functions.readReal(PIInputs,3);
            omega:=Controller.Memory.Functions.readReal(PIInputs,4);

            //switch to state executeControlLaw
            mode:=PLCTaskState.executeControlLaw;
            runTime:=controlLawCycles/CPUFreq;
          elseif (mode==PLCTaskState.executeControlLaw) then

            //the control law
            F := -(kx*x + kv*v + kphi*phi + komega*omega);

            //switch to state writeOutput
            mode:=PLCTaskState.writeOutput;
            runTime:=writeCycles/CPUFreq;
          elseif (mode==PLCTaskState.writeOutput) then

            //write actuator value to process image
            Controller.Memory.Functions.writeReal(PIOutputs,1,F);
            mode:=PLCTaskState.readInputs;
            runTime:=readCycles/CPUFreq;
          end if;
        end when;
      end PLCTask;

      model System
        "Model that performs a comparison in control performance between PLC-based and ideal analog control."
        extends Modelica.Icons.Example;

        annotation(preferedView="diagram",
          experiment(
            StopTime=5,
            Tolerance=1e-006,
            Algorithm="Lsodar"),
          experimentSetupOutput);
        import InvertedPendulum;

        Board.IOBoard PLC(
          no=1,
          ni=5,
          cPU(redeclare Controller.CPU.Scheduler.FIFOScheduler scheduler,
              redeclare Controller.Examples.PLCPIDController.PLCTask task1))
                          annotation (extent=[-74,20; -14,80]);
        annotation (Diagram(
            Line(points=[-100,0; 100,0], style(
                color=3,
                rgbcolor={0,0,255},
                pattern=2,
                thickness=4)),
            Text(
              extent=[0,30; 100,10],
              style(
                color=3,
                rgbcolor={0,0,255},
                pattern=2,
                thickness=4),
              string="PLC based control"),
            Text(
              extent=[-100,0; 0,-20],
              style(
                color=3,
                rgbcolor={0,0,255},
                pattern=2,
                thickness=4),
              string="ideal continuous control")));

        InvertedPendulum.InvertedPendulum plcPendulum(pendulum(phi(start=0.1)))
          annotation (extent=[0,34; 60,94]);
        InvertedPendulum.InvertedPendulum analogControllerPendulum(pendulum(phi(
                start=0.1)))
          annotation (extent=[0,-86; 60,-26]);
        Modelica.Blocks.Math.Gain gainx(k=0.1)
          annotation (extent=[-60,-40; -50,-30], rotation=0);
        Modelica.Blocks.Math.Gain gainv(k=0.3)
          annotation (extent=[-60,-60; -50,-48], rotation=0);
        Modelica.Blocks.Math.Gain gainphi(k=13.6)
          annotation (extent=[-60,-80; -50,-70], rotation=0);
        Modelica.Blocks.Math.Gain gainomega(k=2.3)
          annotation (extent=[-60,-100; -50,-90], rotation=0);
        Modelica.Blocks.Math.Sum sum1(nin=4) annotation (extent=[-30,-80; -10,-60]);
      equation
        connect(PLC.y[1], plcPendulum.F)      annotation (points=[-11,50; -1,50; -1,
              49; 3,49], style(color=74, rgbcolor={0,0,127}));
        connect(plcPendulum.x, PLC.u[1])      annotation (points=[57,82; 78,82; 78,
              96; -80,96; -80,45.2],
                                 style(color=74, rgbcolor={0,0,127}));
        connect(plcPendulum.v, PLC.u[2])      annotation (points=[57,70; 78,70;
              78,96; -80,96; -80,47.6],
                                 style(color=74, rgbcolor={0,0,127}));
        connect(plcPendulum.phi, PLC.u[3])      annotation (points=[57,58; 78,58;
              78,96; -80,96; -80,50],
                                   style(color=74, rgbcolor={0,0,127}));
        connect(plcPendulum.omega, PLC.u[4])      annotation (points=[57,46; 78,
              46; 78,96; -80,96; -80,52.4],
                                        style(color=74, rgbcolor={0,0,127}));
        connect(sum1.y, analogControllerPendulum.F)
                                             annotation (points=[-9,-70; 0,-70; 0,
              -71; 3,-71],
                      style(color=74, rgbcolor={0,0,127}));
        connect(gainx.y, sum1.u[1]) annotation (points=[-49.5,-35; -49.5,-34.5; -32,
              -34.5; -32,-71.5], style(color=74, rgbcolor={0,0,127}));
        connect(gainv.y, sum1.u[2]) annotation (points=[-49.5,-54; -32,-54; -32,-70.5],
            style(color=74, rgbcolor={0,0,127}));
        connect(gainphi.y, sum1.u[3]) annotation (points=[-49.5,-75; -31.75,-75;
              -31.75,-69.5; -32,-69.5], style(color=74, rgbcolor={0,0,127}));
        connect(gainomega.y, sum1.u[4]) annotation (points=[-49.5,-95; -50,-96; -32,
              -96; -32,-68.5], style(color=74, rgbcolor={0,0,127}));
        connect(analogControllerPendulum.x, gainx.u)
                                              annotation (points=[57,-38; 72,-38;
              72,-20; -66,-20; -66,-35; -61,-35],
                                               style(color=74, rgbcolor={0,0,127}));
        connect(analogControllerPendulum.v, gainv.u)
                                              annotation (points=[57,-50; 72,-50;
              72,-20; -66,-20; -66,-54; -61,-54],
                                               style(color=74, rgbcolor={0,0,127}));
        connect(analogControllerPendulum.phi, gainphi.u)
                                                  annotation (points=[57,-62; 72,
              -62; 72,-20; -66,-20; -66,-75; -61,-75],
                                                  style(color=74, rgbcolor={0,0,127}));
        connect(analogControllerPendulum.omega, gainomega.u)
                                                      annotation (points=[57,-74;
              72,-74; 72,-20; -66,-20; -66,-96; -64,-96; -61,-95],
                                                                style(color=74,
              rgbcolor={0,0,127}));
      end System;

    end PLCPIDController;

    package SchedulingExperiments
      "Package that contains models to show influence of scheduling policy on control performance."
      annotation(preferedView="info");
      model SlowInvertedPendulumTask "Slow controller for an inverted pendulum"
        extends Controller.Examples.PLCPIDController.PLCTask(
                                                      readCycles=5000,controlLawCycles=10000, writeCycles=2500);
      end SlowInvertedPendulumTask;

      model SchedulingTestCPU "CPU for the scheduling test."
        extends Controller.CPU.CPU(redeclare SlowInvertedPendulumTask task1,
          redeclare CPU.Task.ParasitaryTask task2(cyclesPerJob=5000),
          redeclare CPU.Task.ParasitaryTask task3(cyclesPerJob=5000),
          redeclare CPU.Task.DummyTask task4)
        annotation (experiment(StopTime=0.1), experimentSetupOutput);
      equation

        annotation (Diagram);
      end SchedulingTestCPU;

      model ControlPerformanceExperiment
        "Model to compare control performance of round robin and FIFO scheduling policy."
        extends Modelica.Icons.Example;
        annotation(preferedView="diagram",
          experiment(
            StopTime=10,
            Tolerance=1e-006,
            Algorithm="Lsodar"),
          experimentSetupOutput(events=false));
        Board.IOBoard RoundRobin(
          no=1,
          ni=5,
          redeclare Controller.Examples.SchedulingExperiments.SchedulingTestCPU
            cPU(redeclare Controller.CPU.Scheduler.RoundRobinScheduler
              scheduler(timeSlice=0.001)))
                          annotation (extent=[-74,24; -14,84]);
        InvertedPendulum.InvertedPendulum roundRobinPendulum(pendulum(phi(start=0.1)))
          annotation (extent=[6,38; 66,98]);
        Board.IOBoard FIFO(
          no=1,
          ni=5,
          redeclare Controller.Examples.SchedulingExperiments.SchedulingTestCPU
            cPU(redeclare Controller.CPU.Scheduler.FIFOScheduler scheduler))
                          annotation (extent=[-74,-76; -14,-16]);
        InvertedPendulum.InvertedPendulum fifoPendulum(pendulum(phi(start=0.1)))
          annotation (extent=[6,-62; 66,-2]);
      equation

        annotation (
          Diagram(
            Text(
              extent=[0,34; 100,14],
              style(
                color=3,
                rgbcolor={0,0,255},
                pattern=2,
                thickness=4),
              string="Round Robin Scheduler"),
            Text(
              extent=[0,-66; 100,-86],
              style(
                color=3,
                rgbcolor={0,0,255},
                pattern=2,
                thickness=4),
              string="FIFO-Scheduler"),
            Line(points=[-100,10; 100,10],
                                         style(
                color=3,
                rgbcolor={0,0,255},
                pattern=2,
                thickness=4))),
          experiment(
            StopTime=10,
            Tolerance=1e-006,
            Algorithm="Lsodar"),
          experimentSetupOutput(events=false));
        connect(RoundRobin.y[1], roundRobinPendulum.F)
                                              annotation (points=[-11,54; -1,54;
              -1,53; 9,53],
                         style(color=74, rgbcolor={0,0,127}));
        connect(roundRobinPendulum.x, RoundRobin.u[1])
                                              annotation (points=[63,86; 78,86;
              78,100; -80,100; -80,49.2],
                                 style(color=74, rgbcolor={0,0,127}));
        connect(roundRobinPendulum.v, RoundRobin.u[2])
                                              annotation (points=[63,74; 78,74;
              78,100; -80,100; -80,51.6],
                                 style(color=74, rgbcolor={0,0,127}));
        connect(roundRobinPendulum.phi, RoundRobin.u[3])
                                                annotation (points=[63,62; 78,
              62; 78,100; -80,100; -80,54],
                                   style(color=74, rgbcolor={0,0,127}));
        connect(roundRobinPendulum.omega, RoundRobin.u[4])
                                                  annotation (points=[63,50; 78,
              50; 78,100; -80,100; -80,56.4],
                                        style(color=74, rgbcolor={0,0,127}));
        connect(FIFO.y[1], fifoPendulum.F)    annotation (points=[-11,-46; -1,
              -46; -1,-47; 9,-47],
                         style(color=74, rgbcolor={0,0,127}));
        connect(fifoPendulum.x, FIFO.u[1])    annotation (points=[63,-14; 78,
              -14; 78,0; -80,0; -80,-50.8],
                                 style(color=74, rgbcolor={0,0,127}));
        connect(fifoPendulum.v, FIFO.u[2])    annotation (points=[63,-26; 78,
              -26; 78,0; -80,0; -80,-48.4],
                                 style(color=74, rgbcolor={0,0,127}));
        connect(fifoPendulum.phi, FIFO.u[3])    annotation (points=[63,-38; 78,
              -38; 78,0; -80,0; -80,-46],
                                   style(color=74, rgbcolor={0,0,127}));
        connect(fifoPendulum.omega, FIFO.u[4])    annotation (points=[63,-50;
              78,-50; 78,0; -80,0; -80,-43.6],
                                        style(color=74, rgbcolor={0,0,127}));
      end ControlPerformanceExperiment;
    end SchedulingExperiments;

    package NCSExample
      "This package contains an example for an networked control system"

      annotation(preferedView="info", Documentation(info="<html>
<p>This package contains models to implement a control system with separate devices for process interfacing and control law execution.
Communication between devices is done by means of ZigBee network.</p>
<P>
The package contains 3 models:<br>
<table border=\"1\">
<tr>
  <td><a href=\"RemoteIOTask\">RemoteIOTask</a></td>
  <td>Task that runs on the device interfacing the process (remote-IO)</td>
</tr>
<tr>
  <td><a href=\"SendTask\">SendTask</a></td>
  <td>Task to periodically request sensor values from the remote-IO and deliver a new set value for the actuator.</td>
</tr>
<tr>
  <td><a href=\"ReceiveTask\">ReceiveTask</a></td>
  <td>Task to handle incoming network messages from the remote-IO, which contain the sensor values.</td>
</tr>
</table><br>

SendTask and ReceiveTask run concurrently on one device and compete for processing time.
</p>
<p>
The process under control is an inverted pendulum.
</p>

</html>"));

      model RemoteIOTask "Task that runs on a remote-IO board"
        extends CPU.Task.NetworkTask;

      package TaskState "Enumeration type to store the state of a task"
        extends Modelica.Icons.Enumeration;

        constant Integer idle=1;
        constant Integer readingMessage=2;
        constant Integer processingMessage= 3;
        constant Integer sendingMessage= 4;

        type Temp
            "special type which is necessary to emulate an enumeration in Dymola."
          extends Modelica.Icons.TypeInteger;
        end Temp;

      end TaskState;

        import Network.Cache.CacheFunctions.*;
        import
          Network.PrimaryController.ProtocolFunctions.ArrayValueDataProtocol.*;
        import Controller.Memory.Functions.*;
        parameter Integer readingMessageCycles=500
          "Processor cycles needed to read an incoming message.";
        parameter Integer processingMessageCycles=1000
          "Processor cycles needed to execute the control law.";
        parameter Integer sendingMessageCycles=500
          "Processor cycles needed to send a network message.";
        parameter Integer numberOfActuatorValues=1
          "Number of actuator signals processed in the task.";
        parameter Integer numberOfSensorValues=4
          "Number of sensor signals processed in the task.";
        Integer receiveCacheID=iCConnector.cacheBusConnector.rcvCacheID;

        Integer messageID;
        TaskState.Temp taskState(start=TaskState.idle);

        Integer source;
        Integer operation;
        Real actuatorValues[numberOfActuatorValues];
        Real sensorValues[numberOfSensorValues];

      algorithm
        sleepTime:=0;

        //if no message is pending and task is not processing a message task should sleep

        if (not
               (time>0)) then
          idle:=true;
        elseif (taskState==TaskState.idle and not
                                             (Network.Cache.CacheFunctions.cacheNotEmpty(
                                                            receiveCacheID))) then
          idle:=true;
        else
          idle:=false;
        end if;

        when (pre(jobFinished)) then

          if (taskState==TaskState.idle) then

            //paramterize task to read a network message
            runTime:=readingMessageCycles/CPUFreq;
            taskState:=TaskState.readingMessage;

          elseif (taskState==TaskState.readingMessage) then

            //deqeue the message from the receive queue of the transceiver
            messageID:=Network.Cache.CacheFunctions.dequeue(
                               receiveCacheID);

            //interpret message according to the ArrayValueDataProtocol
            (source, operation,actuatorValues):=getReceiveMessage(messageID,numberOfActuatorValues);

            //parameterize task to process message
            runTime:=readingMessageCycles/CPUFreq;
            taskState:=TaskState.processingMessage;

          elseif (taskState==TaskState.processingMessage) then

            //apply new set values to actuators
            for i in 1:numberOfActuatorValues loop
              writeReal(PIOutputs,i,actuatorValues[i]);
            end for;

            //get current sensor values from process image of inputs
            for i in 1:numberOfSensorValues loop
              sensorValues[i]:=readReal(PIInputs,i);
            end for;

            //create new network message according to ArrayValueDataProtocol
            messageID:=createSendMessage(source,2,sensorValues);

            //parameterize task to send network message
            runTime:=sendingMessageCycles/CPUFreq;
            taskState:=TaskState.sendingMessage;

          elseif (taskState==TaskState.sendingMessage) then

            //enqueue message to send queue of transceiver
            Network.Cache.CacheFunctions.enqueue(
                    iCConnector.cacheBusConnector.sendCacheID,messageID);

            runTime:=0/CPUFreq;
            taskState:=TaskState.idle;

          end if;

          reinit(runTimer,0);
        end when;
      end RemoteIOTask;

      model SendTask
        "Task to cyclically send actuator signals to a remote-IO board"
        extends CPU.Task.NetworkTask;

        annotation (preferedView="info",Documentation(info="<html>
<p>
This task is used to cyclically send a new actuator value via network and to retrieve at the same time new sensor values.
</p>
<p>
To send a network message one has to do two things in serial:
<ol>
  <li>
Create the message to be send via network using the method CreateSendMessage(..) of the <a href=\"Network\">Network</a> library:<br>
  <br>
messageID:=<font color=\"#ff0000\">Network.PrimaryController.ProtocolFunctions.ArrayValueDataProtocol.CreateSendMessage</font>(2,Network.Operation_Type.ReadSensorValue,actuatorValues);
  </li>
  <br>
  <br>
  <li>
    Enqueue the create message in the send queue of the transceiver using the Enqueue(..) function of the <a href=\"Network\">Network</a> library:<br>
<br>
<font color=\"#ff0000\">Network.Cache.Cache_Functions.Enqueue</font>(iC_Connector.cacheBus_Connector.SendCache_ID,messageID);
  </li>
</ol>
</p>

</html>"));

        parameter Integer sendCycles=1000
          "Processor cycles to send a network message.";
        parameter Modelica.SIunits.Time sendBreak=1e-2
          "Minimum timespan betwenn two network messages.";

        parameter Integer remoteIOAddress=2
          "Network address of the remote IO board";
        Integer messageID;
        Real actuatorValues[1];
        Modelica.SIunits.Force F;
      algorithm
        sleepTime:=0;
        idle:=false;
        runTime:=sendCycles/CPUFreq;

        when
            (pre(jobFinished) and time>0) then

          // read the set value from the memory
          F:=Controller.Memory.Functions.readReal(Memory,1);

          actuatorValues[1]:=F;

          //create the message to be send by network
          messageID:=Network.PrimaryController.ProtocolFunctions.ArrayValueDataProtocol.createSendMessage(remoteIOAddress,Network.OperationType.ReadSensorValue, actuatorValues);

          //enqueue the message on the send queue of the transceiver
          Network.Cache.CacheFunctions.enqueue(iCConnector.cacheBusConnector.sendCacheID,messageID);

          //reset runtimer and goto sleep
          reinit(runTimer,0);
          reinit(sleepTimer,sendBreak);
        end when;
      end SendTask;

      model ReceiveTask
        "Task to handle incoming network messages and to execute the control law for an inverted pendulum."
        extends CPU.Task.NetworkTask;

      package TaskState "Enumeration type to store the state of a task"
        extends Modelica.Icons.Enumeration;

        constant Integer idle=1;
        constant Integer readingMessage=2;
        constant Integer processingMessage= 3;

        type Temp
            "special type which is necessary to emulate an enumeration in Dymola."
          extends Modelica.Icons.TypeInteger;
        end Temp;

      end TaskState;

        import Network.Cache.CacheFunctions.*;
        import
          Network.PrimaryController.ProtocolFunctions.ArrayValueDataProtocol.*;
        import Controller.Memory.Functions.*;
        parameter Integer readingMessageCycles=500
          "Processor cycles needed to read an incoming message.";
        parameter Integer processingMessageCycles=1000
          "Processor cycles needed to execute the control law.";
        parameter Integer sendingMessageCycles=500
          "Processor cycles needed to send a network message.";
        parameter Integer numberOfSensorValues=4
          "The number of sensor values processed in the task.";

        parameter Real kx=-0.1 "The controller gain of the pendulum position.";
        parameter Real kv=-0.3 "The controller gain of the pendulum velocity.";
        parameter Real kphi=-13.6 "The controller gain of the pendulum angle.";
        parameter Real komega=-2.3
          "The controller gain of the pendulum angulat velocity.";

        Integer receiveCacheID=iCConnector.cacheBusConnector.rcvCacheID;

        Integer messageID;
        TaskState.Temp taskState(start=TaskState.idle);

        Integer source;
        Integer operation;
        Real sensorValues[numberOfSensorValues];

        Modelica.SIunits.Force F;
        Modelica.SIunits.Position x;
        Modelica.SIunits.Velocity v;
        Modelica.SIunits.Angle phi;
        Modelica.SIunits.AngularVelocity omega;
      algorithm

        sleepTime:=0;
        if (time >0 and taskState==TaskState.idle and not
                                                         (cacheNotEmpty(receiveCacheID))) then
          idle:=true;
        else
          idle:=false;
        end if;

        when (pre(jobFinished)) then

          if (taskState==TaskState.idle) then

            //parameterize task to perform reading message action
            runTime:=readingMessageCycles/CPUFreq;
            taskState:=TaskState.readingMessage;

          elseif (taskState==TaskState.readingMessage) then

            //dequeue message from receiver queue of transceiver
            messageID:=dequeue(    iCConnector.cacheBusConnector.rcvCacheID);

            //interpret message accoring to ArrayValueDataProtocol
            (source, operation,sensorValues):=getReceiveMessage(messageID,numberOfSensorValues);

            //Assign array values to single variables with meaningful names
            x:=sensorValues[1];
            v:=sensorValues[2];
            phi:=sensorValues[3];
            omega:=sensorValues[4];

            //parameterize task to perform control law execution
            runTime:=readingMessageCycles/CPUFreq;
            taskState:=TaskState.processingMessage;

          elseif (taskState==TaskState.processingMessage) then

            //the control law (state feedback controller)
            F:=-(kx*x+kv*v+kphi*phi+komega*omega);

            //to store new set value in shared memory
            writeReal(Memory,1,F);

            runTime:=0/CPUFreq;
            taskState:=TaskState.idle;
          end if;

          reinit(runTimer,0);
        end when;
        annotation (Diagram);
      end ReceiveTask;

    model DistributedControlSystem
        "Model of a distributed control system, with control loop closed using a network"
        extends Modelica.Icons.Example;

        annotation(preferedView="diagram",Documentation(info="<html>
<p>
This model shows an example application of the <a href=\"Network\">Network</a> and <a href=\"Controller\">Controller</a> libraries in the domain of Networked Control Systems (NCS).
</p>
<p>
The model is a system with two embedded devices used to control an inverted pendulum. The control loop is closed using a ZigBee network.
Only one embedded device is attached to the pendulum, it serves as remote-IO board. The other embedded device is used as controller board which executes the control law.
The controller board cyclically sends an actuator value to the remote-IO board, which at the same time is the request for an update of sensor signals.
</p>
<p>
On the controller board, there are two concurrent tasks running in the CPU.
The task <a href=\"SendTask\">SendTask</a> cyclically sends network messages to update the actuator signal and request new sensor signals.
The task <a href=\"ReceiveTask\">ReceiveTask</a> handles the incoming network messages with the sensor signals and executes the control law.
The actuator signal calculated by the ReceiveTask is shared with the SendTask using the CPU internal memory of type <a href=\"Controller.Memory.RAM\">RAM</a>.
</p>
</html>"),
        Diagram,
        Icon(Text(
            extent=[-100,100; 100,60],
            style(color=3, rgbcolor={0,0,255}),
            string="%class")));

        Board.ZigBeeNetworkIOBoard RemoteIO_1(address=2, cPUWithNetwork(redeclare
              Controller.CPU.Scheduler.RoundRobinScheduler scheduler, redeclare
              Controller.Examples.NCSExample.RemoteIOTask networkTask1))
          annotation (extent=[-30,-20; 10,20]);
        annotation (Diagram(Line(points=[-36,-20; -36,-80],
                                                          style(
              color=0,
              rgbcolor={0,0,0},
              thickness=4,
              arrow=1)), Text(
            extent=[-100,0; -40,-60],
            string="x, v, phi, omega",
            style(
              color=0,
              rgbcolor={0,0,0},
              arrow=1)),    Line(points=[18,-80; 18,-20],
                                                        style(
              color=0,
              rgbcolor={0,0,0},
              thickness=4,
              arrow=1)), Text(
            extent=[22,-28; 30,-38],
            style(
              color=0,
              rgbcolor={0,0,0},
              arrow=1),
            string="F")),
          experiment(StopTime=10, Algorithm="Lsodar"),
          experimentSetupOutput);
        Network.ZigBee.ZigBeeSharedMedium zigBee_sharedmedium
          annotation (extent=[-30,-72; 10,-32]);

        inner constant Integer numberOfWorkpieces=1;
        Board.ZigBeeNetworkBoard zigBeeNetworkBoard(cPUWithNetwork(
          redeclare Controller.CPU.Scheduler.RoundRobinScheduler scheduler,
          redeclare Controller.Examples.NCSExample.SendTask networkTask1,
          redeclare Controller.Examples.NCSExample.ReceiveTask networkTask2))
          annotation (extent=[-80,-80; -40,-40]);
        InvertedPendulum.InvertedPendulum invertedPendulum
          annotation (extent=[20,-20; 80,40]);
    equation

        connect(zigBeeNetworkBoard.networkPort, zigBee_sharedmedium.networkPort[
          1]) annotation (points=[-60,-76; -8,-76; -8,-51.8; -10.2,-51.8],
            style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(RemoteIO_1.networkPort, zigBee_sharedmedium.networkPort[2])
          annotation (points=[-10,-16; -10,-51.8; -10.2,-51.8],
                                                          style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(RemoteIO_1.y[1], invertedPendulum.F) annotation (points=[12,-1.8;
            16,-1.8; 16,-2; 23,-2; 23,-5],
                                         style(color=74, rgbcolor={0,0,127}));
      connect(invertedPendulum.x, RemoteIO_1.u[1]) annotation (points=[77,28; 72,28;
            72,44; -52,44; -52,-3.6; -34,-3.6], style(color=74, rgbcolor={0,0,127}));
      connect(invertedPendulum.v, RemoteIO_1.u[2]) annotation (points=[77,16;
              74,16; 74,46; -54,46; -54,-2.8; -34,-2.8],
                                                style(color=74, rgbcolor={0,0,127}));
      connect(invertedPendulum.phi, RemoteIO_1.u[3]) annotation (points=[77,4; 76,4;
            76,48; -56,48; -56,-2; -34,-2],     style(color=74, rgbcolor={0,0,127}));
      connect(invertedPendulum.omega, RemoteIO_1.u[4]) annotation (points=[77,-8;
              78,-8; 78,50; -58,50; -58,-1.2; -34,-1.2],
                                                       style(color=74, rgbcolor={0,
              0,127}));
    end DistributedControlSystem;
    end NCSExample;

    package NetworkedAutomationSystem
      model NetworkedAutomationSystem
        Network.Ethernet.Switch4Ports switch4Ports
          annotation (extent=[-60,82; -20,42], rotation=0);
        Network.Ethernet.Switch4Ports switch4Ports1
          annotation (extent=[20,82; 60,42], rotation=0);
        Network.Ethernet.Cable cable
          annotation (extent=[-10,40; 10,60], rotation=180);
        annotation (Diagram);
        Network.Ethernet.Cable cable1
          annotation (extent=[-69,21; -49,41], rotation=90);
        Network.Ethernet.Cable cable2
          annotation (extent=[23,20; 43,40], rotation=90);
        Network.Ethernet.Cable cable3
          annotation (extent=[48,20; 68,40], rotation=90);
        Network.Ethernet.Cable cable4
          annotation (extent=[-45,21; -25,41], rotation=90);
        Network.Ethernet.EthernetTransceiverModul ethernet_TransceiverModul
          annotation (extent=[-100,-38; -60,2]);
        Network.Ethernet.EthernetTransceiverModul ethernet_TransceiverModul1
          annotation (extent=[-60,-38; -20,2]);
        Network.Ethernet.EthernetTransceiverModul ethernet_TransceiverModul2
          annotation (extent=[0,-38; 40,2]);
        Network.Ethernet.EthernetTransceiverModul ethernet_TransceiverModul3
          annotation (extent=[40,-38; 80,2]);
        Network.Ethernet.EthernetPrimaryController ethernetPrimaryController
          annotation (extent=[-102,-84; -62,-44], rotation=90);
        Network.Ethernet.EthernetPrimaryController ethernetPrimaryController1
          annotation (extent=[-68,-84; -28,-44], rotation=90);
        Network.Ethernet.EthernetPrimaryController ethernetPrimaryController2
          annotation (extent=[-8,-84; 32,-44], rotation=90);
        Network.Ethernet.EthernetPrimaryController ethernetPrimaryController3
          annotation (extent=[34,-84; 74,-44], rotation=90);
      equation
        connect(cable.ethernetPort_R, switch4Ports.ethernetPort_3) annotation (
            points=[-7.4,50.7; -34,50.7; -34,44.8],               style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(cable2.ethernetPort_R, switch4Ports1.ethernetPort_1)
          annotation (points=[33.7,37.4; 33.7,39.7; 21.6,39.7; 21.6,45.2],
                                                                     style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(cable3.ethernetPort_R, switch4Ports1.ethernetPort_3)
          annotation (points=[58.7,37.4; 58.7,38.7; 46,38.7; 46,44.8], style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(cable4.ethernetPort_R, switch4Ports.ethernetPort_2) annotation (
           points=[-34.3,38.4; -34.3,39.7; -49.2,39.7; -49.2,45],
                                                                style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(ethernet_TransceiverModul.networkPort, cable1.ethernetPort_L)
          annotation (points=[-69.6,-1.4; -69.6,-0.7; -58.3,-0.7; -58.3,23],
            style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(ethernet_TransceiverModul1.networkPort, cable4.ethernetPort_L)
          annotation (points=[-29.6,-1.4; -34.3,-1.4; -34.3,23], style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(ethernet_TransceiverModul2.networkPort, cable2.ethernetPort_L)
          annotation (points=[30.4,-1.4; 30.4,-0.7; 33.7,-0.7; 33.7,22], style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(ethernet_TransceiverModul3.networkPort, cable3.ethernetPort_L)
          annotation (points=[70.4,-1.4; 58.7,-1.4; 58.7,22], style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(ethernetPrimaryController.iCConnector,
          ethernet_TransceiverModul.iCConnector) annotation (points=[-84.8,
              -49.2; -84.8,-42; -89.6,-42; -89.6,-33.4], style(
            color=2,
            rgbcolor={0,255,0},
            thickness=4));
        connect(ethernetPrimaryController2.iCConnector,
          ethernet_TransceiverModul2.iCConnector) annotation (points=[9.2,-49.2;
              9.2,-34; 10,-34; 10,-33.4; 10.4,-33.4],        style(
            color=2,
            rgbcolor={0,255,0},
            thickness=4));
        connect(ethernetPrimaryController3.iCConnector,
          ethernet_TransceiverModul3.iCConnector) annotation (points=[51.2,
              -49.2; 51.2,-34; 50,-34; 50.4,-33.4], style(
            color=2,
            rgbcolor={0,255,0},
            thickness=4));
        connect(ethernetPrimaryController1.iCConnector,
          ethernet_TransceiverModul1.iCConnector) annotation (points=[-50.8,
              -49.2; -50.8,-42.6; -49.6,-42.6; -49.6,-33.4], style(
            color=2,
            rgbcolor={0,255,0},
            thickness=4));
        connect(switch4Ports.ethernetPort_1, cable1.ethernetPort_R) annotation
          (points=[-58.4,45.2; -58.4,42.6; -58.3,42.6; -58.3,38.4], style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
        connect(cable.ethernetPort_L, switch4Ports1.ethernetPort_2) annotation
          (points=[8,50.7; 20,50.7; 20,45; 30.8,45], style(
            color=3,
            rgbcolor={0,0,255},
            thickness=4));
      end NetworkedAutomationSystem;

      model AppetizerModel

        InvertedPendulum.InvertedPendulum analogControllerPendulum(pendulum(phi(
                start=0.25)))
          annotation (extent=[-20,-30; 60,50]);
        annotation (Diagram);
        Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus
          controlBus annotation (extent=[66,2; 106,42]);
        Controller controller annotation (extent=[-50,-20; -30,0]);
      equation
        connect(analogControllerPendulum.x, controlBus.x) annotation (
          points=[56,34; 68,34; 68,22; 86,22],
          style(
            color=74,
            rgbcolor={0,0,127},
            thickness=4),
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})));
        connect(analogControllerPendulum.phi, controlBus.phi) annotation (
          points=[56,2; 82,2; 82,22; 86,22],
          style(
            color=74,
            rgbcolor={0,0,127},
            thickness=4),
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})));
        connect(analogControllerPendulum.omega, controlBus.omega) annotation (
          points=[56,-14; 86,-14; 86,22],
          style(
            color=74,
            rgbcolor={0,0,127},
            thickness=4),
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})));
        connect(controller.y, analogControllerPendulum.F) annotation (points=[
              -31,-10; -16,-10], style(
            color=74,
            rgbcolor={0,0,127},
            thickness=4));
        connect(controlBus, controller.controlBus) annotation (
          points=[86,22; 86,54; -72,54; -72,-10; -50,-10],
          style(
            color=6,
            rgbcolor={255,204,51},
            thickness=2),
          Text(
            string="%first",
            index=-1,
            extent=[-6,3; -6,3],
            style(color=0, rgbcolor={0,0,0})));
        connect(analogControllerPendulum.v, controlBus.v) annotation (
          points=[56,18; 80,18; 80,22; 86,22],
          style(
            color=74,
            rgbcolor={0,0,127},
            thickness=4),
          Text(
            string="%second",
            index=1,
            extent=[6,3; 6,3],
            style(color=0, rgbcolor={0,0,0})));
      end AppetizerModel;

      model Controller
        Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus
          controlBus annotation (extent=[-120,-20; -80,20], rotation=90);
        Modelica.Blocks.Math.Gain gainx(k=0.1)
          annotation (extent=[-40,48; -20,68],   rotation=0);
        Modelica.Blocks.Math.Gain gainv(k=0.3)
          annotation (extent=[-40,10; -20,30],   rotation=0);
        Modelica.Blocks.Math.Gain gainphi(k=13.6)
          annotation (extent=[-40,-30; -20,-10], rotation=0);
        Modelica.Blocks.Math.Gain gainomega(k=2.3)
          annotation (extent=[-40,-70; -20,-50],  rotation=0);
        Modelica.Blocks.Math.Sum sum1(nin=4) annotation (extent=[40,-10; 60,10]);
        annotation (Diagram);
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (extent=[80,-10; 100,10]);
      equation
        connect(controlBus.x, gainx.u) annotation (
          points=[-100,0; -100,6; -80,6; -80,58; -42,58],
          style(
            color=6,
            rgbcolor={255,204,51},
            thickness=2),
          Text(
            string="%first",
            index=-1,
            extent=[-6,3; -6,3],
            style(color=0, rgbcolor={0,0,0})));
        connect(controlBus.phi, gainphi.u) annotation (
          points=[-100,0; -96,0; -96,-4; -78,-4; -78,-20; -42,-20],
          style(
            color=6,
            rgbcolor={255,204,51},
            thickness=2),
          Text(
            string="%first",
            index=-1,
            extent=[-6,3; -6,3],
            style(color=0, rgbcolor={0,0,0})));
        connect(controlBus.omega, gainomega.u) annotation (
          points=[-100,0; -100,-6; -80,-6; -80,-34; -42,-34; -42,-60],
          style(
            color=6,
            rgbcolor={255,204,51},
            thickness=2),
          Text(
            string="%first",
            index=-1,
            extent=[-6,3; -6,3],
            style(color=0, rgbcolor={0,0,0})));
        connect(gainx.y, sum1.u[1]) annotation (points=[-19,58; 8,58; 8,-1.5;
              38,-1.5], style(
            color=74,
            rgbcolor={0,0,127},
            thickness=4));
        connect(gainv.y, sum1.u[2]) annotation (points=[-19,20; 10,20; 10,-0.5;
              38,-0.5], style(
            color=74,
            rgbcolor={0,0,127},
            thickness=4));
        connect(gainphi.y, sum1.u[3]) annotation (points=[-19,-20; 8,-20; 8,0.5;
              38,0.5], style(
            color=74,
            rgbcolor={0,0,127},
            thickness=4));
        connect(gainomega.y, sum1.u[4]) annotation (points=[-19,-60; 8,-60; 8,
              1.5; 38,1.5], style(
            color=74,
            rgbcolor={0,0,127},
            thickness=4));
        connect(sum1.y, y) annotation (points=[61,0; 90,0], style(
            color=74,
            rgbcolor={0,0,127},
            thickness=4));
        connect(controlBus.v, gainv.u) annotation (
          points=[-100,0; -72,0; -72,20; -42,20],
          style(
            color=6,
            rgbcolor={255,204,51},
            thickness=2),
          Text(
            string="%first",
            index=-1,
            extent=[-6,3; -6,3],
            style(color=0, rgbcolor={0,0,0})));
      end Controller;

      model InformationSource
        annotation (Icon(Text(
              extent=[-80,40; 60,-40],
              string="information source",
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=4)), Rectangle(extent=[-80,60; 60,-60], style(
                color=0,
                rgbcolor={0,0,0},
                thickness=4))), Diagram);
        IDConnector iDConnector annotation (extent=[60,-20; 100,20]);
      end InformationSource;

      model InformationSink
        annotation (Icon(Text(
              extent=[-60,40; 80,-40],
              style(
                color=0,
                rgbcolor={0,0,0},
                thickness=4),
              string="information sink"), Rectangle(extent=[-60,60; 80,-60],
                style(
                color=0,
                rgbcolor={0,0,0},
                thickness=4))), Diagram);
        IDConnector iDConnector annotation (extent=[-100,-20; -60,20]);
      end InformationSink;

      connector IDConnector
      end IDConnector;

      model Testmodel
        InformationSource InformationSource
          annotation (extent=[-100,-40; -20,40]);
        annotation (Diagram);
        InformationSink InformationSink annotation (extent=[20,-40; 100,40]);
      equation
        connect(InformationSink.iDConnector, InformationSource.iDConnector)
          annotation (points=[28,0; -28,0], style(
            color=3,
            rgbcolor={0,0,255},
            pattern=2,
            thickness=4));
      end Testmodel;

      model SendTask
        "Task to cyclically send actuator signals to a remote-IO board"
        import Controller;
      import Network.OperationType;
      import
          Network.PrimaryController.ProtocolFunctions.SingleValueDataProtocol;
      import Network.Cache.CacheFunctions;
        extends CPU.Task.NetworkTask;

        annotation (preferedView="info",Documentation(info="<html>
<p>
This task is used to cyclically send a new actuator value via network and to retrieve at the same time new sensor values.
</p>
<p>
To send a network message one has to do two things in serial:
<ol>
  <li>
Create the message to be send via network using the method CreateSendMessage(..) of the <a href=\"Network\">Network</a> library:<br>
  <br>
messageID:=<font color=\"#ff0000\">Network.PrimaryController.ProtocolFunctions.ArrayValueDataProtocol.CreateSendMessage</font>(2,Network.Operation_Type.ReadSensorValue,actuatorValues);
  </li>
  <br>
  <br>
  <li>
    Enqueue the create message in the send queue of the transceiver using the Enqueue(..) function of the <a href=\"Network\">Network</a> library:<br>
<br>
<font color=\"#ff0000\">Network.Cache.Cache_Functions.Enqueue</font>(iC_Connector.cacheBus_Connector.SendCache_ID,messageID);
  </li>
</ol>
</p>

</html>"));

        parameter Integer sendCycles=1000
          "Processor cycles to send a network message.";
        parameter Modelica.SIunits.Time sendBreak=1e-2
          "Minimum timespan betwenn two network messages.";

        parameter Integer remoteIOAddress=2
          "Network address of the remote IO board";
        Integer messageID;
        Real actuatorValues[1];
        Modelica.SIunits.Force F;
      algorithm
        sleepTime:=0;
        idle:=false;
        runTime:=sendCycles/CPUFreq;

        when
            (pre(jobFinished) and time>0) then

          // read the set value from the memory
          F := Controller.Memory.Functions.readReal(Memory, 1);

          actuatorValues[1]:=F;

          //create the message to be sent via network to node with address 1
          messageID:=SingleValueDataProtocol.createSendMessage(1,OperationType.UpdateActuatorValue,2.7);
          //enqueue the message on the send queue of the transceiver
          CacheFunctions.enqueue(iCConnector.cacheBusConnector.sendCacheID,messageID);

          //create the message to be sent via network to node with address 2
          messageID:=SingleValueDataProtocol.createSendMessage(2,OperationType.ReadSensorValue, 0);
          //enqueue the message on the send queue of the transceiver
          CacheFunctions.enqueue(iCConnector.cacheBusConnector.sendCacheID,messageID);

          //reset runtimer and goto sleep
          reinit(runTimer,0);
          reinit(sleepTimer,sendBreak);
        end when;
      end SendTask;
    end NetworkedAutomationSystem;
  end Examples;
end Controller;
