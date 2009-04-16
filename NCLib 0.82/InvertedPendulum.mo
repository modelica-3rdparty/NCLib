package InvertedPendulum
  "Package that contains models to implement an inverted pendulum"

  model Cart "Model of a cart with fixed vertical position"

    Modelica.Blocks.Interfaces.RealInput F(redeclare type SignalType =
          Modelica.SIunits.Force)
      "Force accelerating the cart in horizontal direction"
      annotation (extent=[-100, -10; -80, 10]);
    Flange flange "Flange to attach the pendulum to the cart." annotation (extent=[-10,28; 10,48]);
    Modelica.SIunits.Impulse px
      "The impuls of the cart in horizontal direction";
    Modelica.Blocks.Interfaces.RealOutput x(redeclare type SignalType =
          Modelica.SIunits.Position)
      "The position of the cart in horizontal direction"
      annotation (extent=[80, 50; 100, 70]);
    Modelica.Blocks.Interfaces.RealOutput v(redeclare type SignalType =
          Modelica.SIunits.Velocity)
      "Velocity of the cart in horizontal direction"
      annotation (extent=[80, 10; 100, 30]);

    parameter Modelica.SIunits.Mass m=0.5 "Mass of the cart";

  equation
    //impulse of the cart
    px = m*v;

    //Impulse bilance
    der(px) = F + flange.Fx;

    //derive the velocity of the cart
    der(flange.x) = v;

    //cart is fixed in vertical direction
    flange.y = 0;

    //assign the output value of the posiiton
    x = flange.x;

    annotation (Icon(
        Rectangle(extent=[-80,40; 80,-20], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=10,
            rgbfillColor={135,135,135})),
        Ellipse(extent=[-60,-20; -40,-40], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=10,
            rgbfillColor={135,135,135})),
        Ellipse(extent=[40,-20; 60,-40], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=10,
            rgbfillColor={135,135,135})),
        Text(
          extent=[-80,40; 80,-20],
          style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=10,
            rgbfillColor={135,135,135},
            fillPattern=1),
          string="m=%m kg")),
        Diagram);
  end Cart;

  connector Flange
    flow Modelica.SIunits.Force Fx;
    flow Modelica.SIunits.Force Fy;
    Modelica.SIunits.Position x;
    Modelica.SIunits.Position y;
    annotation (Icon(Rectangle(extent=[-80,80; 80,-80], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=10,
            rgbfillColor={135,135,135},
            fillPattern=1))));
  end Flange;

  model Pendulum "Model of a pendulum arm"

    Flange flange annotation (extent=[-10,-50; 10,-30]);
    annotation (Diagram, Icon(
        Polygon(points=[30,68; -2,-30; 2,-30; 34,66; 30,68], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=9,
            rgbfillColor={175,175,175})),
        Ellipse(extent=[18,88; 48,58], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=9,
            rgbfillColor={175,175,175},
            fillPattern=1)),
        Text(
          extent=[18,88; 48,58],
          style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=9,
            rgbfillColor={175,175,175},
            fillPattern=1),
          string="m = %m kg"),
        Line(points=[0,-30; 0,80], style(
            color=0,
            rgbcolor={0,0,0},
            pattern=2,
            fillColor=9,
            rgbfillColor={175,175,175},
            fillPattern=1)),
        Line(points=[0,60; 24,54], style(
            color=0,
            rgbcolor={0,0,0},
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1)),
        Text(
          extent=[2,56; 20,40],
          style(
            color=0,
            rgbcolor={0,0,0},
            pattern=2,
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1),
          string="phi")));
    Modelica.Blocks.Interfaces.RealOutput phi(redeclare type SignalType =
          Modelica.SIunits.Angle)
      annotation (extent=[80, 50; 100, 70]);
    Modelica.Blocks.Interfaces.RealOutput omega(redeclare type SignalType =
          Modelica.SIunits.AngularVelocity)
      annotation (extent=[80, 10; 100, 30]);

    //Parameters
    parameter Modelica.SIunits.Mass m=0.5
      "Concentrated mass at the end of the pendulum arm.";
    parameter Modelica.SIunits.Length l=1 "The length of the pendulum arm.";

    //internal variables
    Modelica.SIunits.Position x "Position of the mass in horizontal direction.";
    Modelica.SIunits.Position y "Position of the mass in vertical direction.";
    Modelica.SIunits.Velocity vx
      "Velocity of the mass in horizontal direction.";
    Modelica.SIunits.Velocity vy "Velocity of the mass in vertical direction.";
    Modelica.SIunits.Velocity vfx
      "Velocity of the flange point in vertical direction";
    Modelica.SIunits.Impulse px "Impulse of the mass in horizontal direction";
    Modelica.SIunits.Impulse py "Impulse of the mass in vertical direction";

  equation
    omega = der(phi);

    x = flange.x + sin(phi)*l;
    y = flange.y + cos(phi)*l;

    vx = der(x);
    vy = der(y);

    -der(vx)*cos(phi) + der(vy)*sin(phi) = -Modelica.Constants.g_n*sin(phi);

    der(flange.x) = vfx;

    if (cardinality(flange) == 0) then
      flange.x = 0;
      flange.y = 0;
    else
      m*der(vx) = flange.Fx;
      m*der(vy) = flange.Fy;
    end if;

    px = m*vx;
    py = m*vy;

  end Pendulum;

  model InvertedPendulum

    annotation(preferedView="info",Documentation(info="<html>
<p>
This model implements an inverted pendulum that is accelerated by a translational force.
</p>
</html>"),
      Icon(
        Polygon(points=[30,78; -2,-20; 2,-20; 34,76; 30,78], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=9,
            rgbfillColor={175,175,175})),
        Ellipse(extent=[18,98; 48,68], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=9,
            rgbfillColor={175,175,175},
            fillPattern=1)),
        Text(
          extent=[18,98; 48,68],
          style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=9,
            rgbfillColor={175,175,175},
            fillPattern=1),
          string="m = %mp kg"),
        Line(points=[0,-20; 0,90], style(
            color=0,
            rgbcolor={0,0,0},
            pattern=2,
            fillColor=9,
            rgbfillColor={175,175,175},
            fillPattern=1)),
        Line(points=[0,70; 24,64], style(
            color=0,
            rgbcolor={0,0,0},
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1)),
        Text(
          extent=[2,66; 20,50],
          style(
            color=0,
            rgbcolor={0,0,0},
            pattern=2,
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1),
          string="phi"),
        Rectangle(extent=[-80,-20; 80,-80], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=10,
            rgbfillColor={135,135,135})),
        Ellipse(extent=[-60,-80; -40,-100], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=10,
            rgbfillColor={135,135,135})),
        Ellipse(extent=[40,-80; 60,-100], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=10,
            rgbfillColor={135,135,135})),
        Text(
          extent=[-80,-20; 80,-80],
          style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=10,
            rgbfillColor={135,135,135},
            fillPattern=1),
          string="m=%mc kg"),
        Text(
          extent=[92,80; 112,60],
          style(color=3, rgbcolor={0,0,255}),
          string="x"),
        Text(
          extent=[90,40; 110,20],
          style(color=3, rgbcolor={0,0,255}),
          string="v"),
        Text(
          extent=[90,6; 110,-14],
          style(color=3, rgbcolor={0,0,255}),
          string="phi"),
        Text(
          extent=[90,-34; 110,-54],
          style(color=3, rgbcolor={0,0,255}),
          string="omega")),
      Diagram);
    Cart cart(m=mc)     annotation (extent=[-40,-80; 40,0]);
    annotation (Diagram, Icon(
        Ellipse(extent=[-44, -26; -34, -36], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1)),
        Rectangle(extent=[-80, -30; 0, -70], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            fillColor=9,
            rgbfillColor={175,175,175})),
        Ellipse(extent=[-70, -70; -50, -90], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            fillColor=9,
            rgbfillColor={175,175,175})),
        Ellipse(extent=[-30, -70; -10, -90], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            fillColor=9,
            rgbfillColor={175,175,175})),
        Line(points=[-38, -30; -6, 68], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4)),
        Ellipse(extent=[-14, 84; 6, 64], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            gradient=3,
            fillColor=10,
            rgbfillColor={95,95,95})),
        Line(points=[-38, -30; -38, 90], style(
            color=0,
            rgbcolor={0,0,0},
            pattern=2,
            thickness=4,
            fillColor=9,
            rgbfillColor={175,175,175},
            fillPattern=1)),
        Line(points=[-38, 64; -10, 58], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1)),
        Text(
          extent=[-36, 60; -14, 40],
          style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillPattern=1),
          string="phi"),
        Text(
          extent=[40, 70; 80, 50],
          style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1),
          string="x"),
        Text(
          extent=[40, 30; 80, 10],
          style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1),
          string="v"),
        Text(
          extent=[40, -10; 80, -30],
          style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1),
          string="phi"),
        Text(
          extent=[40, -50; 80, -70],
          style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1),
          string="omega"),
        Text(
          extent=[-100, -2; -60, -22],
          style(
            color=0,
            rgbcolor={0,0,0},
            thickness=4,
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1),
          string="F"),
        Line(points=[-100, -20; -60, -20], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=2,
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1)),
        Text(
          extent=[-22, 100; 18, 80],
          style(
            color=0,
            rgbcolor={0,0,0},
            thickness=2,
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1),
          string="m = %m kg"),
        Text(
          extent=[-60, -40; -20, -60],
          style(
            color=0,
            rgbcolor={0,0,0},
            thickness=2,
            arrow=1,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1),
          string="M = %M kg"),
        Line(points=[-22, -28; 12, 70], style(
            color=0,
            rgbcolor={0,0,0},
            thickness=2,
            arrow=3,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1)),
        Text(
          extent=[4, 48; 44, 28],
          style(
            color=0,
            rgbcolor={0,0,0},
            thickness=2,
            arrow=3,
            fillColor=0,
            rgbfillColor={0,0,0},
            fillPattern=1),
          string="l = %l m")));
    Pendulum pendulum(
      l=l,
      phi(start=0.25),
      m=mp)
           annotation (extent=[-40,-48; 40,32]);
    Modelica.Blocks.Interfaces.RealInput F(redeclare type SignalType =
          Modelica.SIunits.Force)
      "Force accelerating the cart in horizontal direction"
      annotation (extent=[-100, -60; -80, -40]);
    Modelica.Blocks.Interfaces.RealOutput x(redeclare type SignalType =
          Modelica.SIunits.Position) "Horizontal position of the cart"
      annotation (extent=[80,50; 100,70]);
    Modelica.Blocks.Interfaces.RealOutput v(redeclare type SignalType =
          Modelica.SIunits.Velocity) "Velocity in horizontal direction"
      annotation (extent=[80, 10; 100, 30]);
    Modelica.Blocks.Interfaces.RealOutput phi(redeclare type SignalType =
          Modelica.SIunits.Angle) "Angle of the pendulum arm"
      annotation (extent=[80, -30; 100, -10]);
    Modelica.Blocks.Interfaces.RealOutput omega(redeclare type SignalType =
          Modelica.SIunits.AngularVelocity)
      "Angular velocity of the pendulum arm"
      annotation (extent=[80, -70; 100, -50]);

    parameter Modelica.SIunits.Mass mc=0.5;
    parameter Modelica.SIunits.Mass mp=0.5;
    parameter Modelica.SIunits.Length l=1;

  equation
    connect(pendulum.flange, cart.flange) annotation (points=[0,-24; 0,-24.8],
        style(
        color=10,
        rgbcolor={135,135,135},
        thickness=4,
        arrow=1,
        fillColor=10,
        rgbfillColor={135,135,135}));
    connect(cart.x, x) annotation (points=[36,-16; 64,-16; 64,60; 90,60], style(
        color=74,
        rgbcolor={0,0,127},
        thickness=4,
        arrow=1,
        fillColor=10,
        rgbfillColor={135,135,135},
        fillPattern=1));
    connect(cart.v, v) annotation (points=[36,-32; 72,-32; 72,20; 90,20], style(
        color=74,
        rgbcolor={0,0,127},
        thickness=4,
        arrow=1,
        fillColor=10,
        rgbfillColor={135,135,135},
        fillPattern=1));
    connect(pendulum.omega, omega) annotation (points=[36,0; 46,0; 46,-60;
          90,-60],
                style(
        color=74,
        rgbcolor={0,0,127},
        thickness=4,
        arrow=1,
        fillColor=10,
        rgbfillColor={135,135,135},
        fillPattern=1));
    connect(pendulum.phi, phi) annotation (points=[36,16; 54,16; 54,-20; 90,
          -20],
        style(
        color=74,
        rgbcolor={0,0,127},
        thickness=4,
        arrow=1,
        fillColor=10,
        rgbfillColor={135,135,135},
        fillPattern=1));
    connect(F, cart.F) annotation (points=[-90,-50; -64,-50; -64,-40; -36,-40],
        style(
        color=74,
        rgbcolor={0,0,127},
        thickness=4,
        arrow=1,
        fillColor=10,
        rgbfillColor={135,135,135},
        fillPattern=1));
  end InvertedPendulum;

  annotation (uses(Modelica(version="2.2.2")));
end InvertedPendulum;
