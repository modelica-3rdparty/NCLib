package List
  "Package with models and functions to implement a list with finite number of elements"
  record List
    "Data structure of a List for Integer elements with limited capacity"
    parameter Integer size "The capacity of the list.";
    Integer numberOfElements(start=0)
      "The number of elements currently stored in the list.";
    Integer elements[size] "The Integer array storing the Integer values.";
  end List;

  function contains
    "function to retrieve if the list contains a  certain element"
    input List list "The list to check for the element";
    input Integer element "The element to be checked";
    output Boolean result
      "true: the list contains the element, false: the list does not contain the element";
  algorithm

    result:=false;

    for i in 1:list.numberOfElements loop
      if (list.elements[i]==element) then
        result:=true;
      end if;
    end for;

  end contains;

  function getFirst "function to get the first element"
    input List list "the list to read the first element from";
    output Boolean successful
      "true: reading was successful, false: list is empty";
    output Integer element "the first element in the list";
  algorithm
    (successful,element):=get(list,1);
  end getFirst;

  function get "function to get the element at a given poition"
    input List list "the list to read the element from";
    input Integer position "the position to read from";
    output Boolean successful
      "true: reading was successful, false: no element at the given position";
    output Integer element "the element in the list at the given position";
  algorithm
    if (not (isEmpty(
                   list))) then
      element:=list.elements[position];
      successful:=true;
    else
      element:=0;
      successful:=false;
    end if;
  end get;

  function isEmpty "function to query if the list is empty"
    input List list "the list to check for emptiness";
    output Boolean result "true: list is empty, false: list is not empty";

  algorithm
    if (list.numberOfElements==0) then
      result:=true;
    else
      result:=false;
    end if;
  end isEmpty;

protected
  function createVector
    input Integer size;
    input Integer value=0;
    output Integer vector[size];
  algorithm
    for i in 1:size loop
      vector[i]:=value;
    end for;
  end createVector;

public
  function add "function to add an element in a list"
    input List list "The list in which the element is added";
    input Integer element "The element to add";
    output Boolean successful
      "true: value was added, false: value was not added because list is full";

    output Integer numberOfElements;
    output Integer elements[list.size];

  protected
  List resultList(
      size=list.size,
      numberOfElements=list.numberOfElements,
      elements=list.elements) "the list where the element was added (or not)";

  algorithm
    if (resultList.numberOfElements<resultList.size) then
      resultList.elements[resultList.numberOfElements+1]:=element;
      resultList.numberOfElements:=resultList.numberOfElements + 1;
      successful:=true;
    else
      successful:=false;
    end if;

    numberOfElements:=resultList.numberOfElements;
    elements:=resultList.elements;

  end add;

public
  function remove "function to remove an element from a list"
    input List list "The list in which the element is added";
    input Integer position "The position to remove the element from";

    output Boolean successful
      "true: element has been removed, false: element has not been removed as it does not exist.";

    output Integer numberOfElements "The number of elements after removal.";
    output Integer elements[list.size]
      "The new collection of elements in the list.";

  protected
  List resultList(
      size=list.size,
      numberOfElements=list.numberOfElements,
      elements=list.elements) "the list where the element was added (or not)";

  algorithm
    if (position<=resultList.numberOfElements) then

      for i in position:resultList.numberOfElements-1 loop
        resultList.elements[i]:=resultList.elements[i + 1];
      end for;

      resultList.numberOfElements:=resultList.numberOfElements - 1;
      successful:=true;
    else
      successful:=false;
    end if;

    numberOfElements:=resultList.numberOfElements;
    elements:=resultList.elements;

  end remove;

public
  function insert "function to insert an element in a list"
    input List list "The list in which the element is added";
    input Integer position "The position to insert the element to";
    input Integer element "The element to add";
    output Boolean successful
      "true: value was added, false: value was not added because list is full";

    output Integer numberOfElements;
    output Integer elements[list.size];

  protected
  List resultList(
      size=list.size,
      numberOfElements=list.numberOfElements,
      elements=list.elements) "the list where the element was added (or not)";
  Integer tempValue;
  algorithm
    if (resultList.numberOfElements<resultList.size) then
      Modelica.Utilities.Streams.print("position: "+String(position));
      for i in resultList.numberOfElements:-1:position loop
        Modelica.Utilities.Streams.print("i: "+String(i));
        resultList.elements[i+1]:=resultList.elements[i];
      end for;

      resultList.elements[position]:=element;

      resultList.numberOfElements:=resultList.numberOfElements+1;
      successful:=true;
    else
      successful:=false;
    end if;

    numberOfElements:=resultList.numberOfElements;
    elements:=resultList.elements;

  end insert;

  function firstPositionOf
    "function to get the first position of the given element"
    input List list "the list to read the element from";
    input Integer element "the position to read from";
    output Boolean successful
      "true: reading was successful, false: no element at the given position";
    output Integer position
      "The position of the first occurance of the element";
  protected
    Boolean found;
  algorithm

    if (contains(list,element)) then
        found:=false;
      for i in 1:list.numberOfElements loop
        if (list.elements[i]==element and not
                                             (found)) then
          position:=i;
          found:=true;
        end if;
      end for;
      successful:=true;
    else
      position:=0;
      successful:=false;
    end if;
  end firstPositionOf;

  package UnitTests "Unit tests to check the package for correctness"

    model TestCaseTemplate
      import List.*;
      List list(size=3);
    algorithm

      //Create a list with size 10 and two stored elements {1,2}
      (list.numberOfElements,list.elements):=testSetup();

      //insert the test case here

    end TestCaseTemplate;

    model ContainsTestCase
      import List.*;
      List list(size=10);
    algorithm

      //Create a list with size 10 and two stored elements {1,2}
      (list.numberOfElements,list.elements):=testSetup();

      assert(contains(list,1),"Contains test case failed");

      assert(contains(list,2),"Contains test case failed");

      assert(not
                (contains(list,3)),"Contains test case failed");

      when (terminal()) then
        Modelica.Utilities.Streams.print("ContainsTestCase passed");
      end when;

    end ContainsTestCase;

    model AddTestCase
      import List.*;
      List list(size=3);
    algorithm

      //Create a list with size 10 and two stored elements {1,2}
      (list.numberOfElements,list.elements):=testSetup();

      (,list.numberOfElements,list.elements):=add(list,3);

      assert(contains(list,3),"AddTestCaseFailed");

      add(list,4);

      assert(not
                (contains(list,4)),"AddTestCaseFailed");

      when (terminal()) then
        Modelica.Utilities.Streams.print("AddTestCase passed");
      end when;

    end AddTestCase;

    model GetFirstTestCase
      import List.*;
      List list(size=3);
      Integer firstElement;
      Boolean success;
    algorithm

      //Create a list with size 10 and two stored elements {1,2}
      (list.numberOfElements,list.elements):=testSetup();

      (success,firstElement):=getFirst(list);
      assert(firstElement==1 and success,"GetFirstTestCase failed");

      (success,list.numberOfElements,list.elements):=remove(list,1);

      (success,firstElement):=getFirst(list);
       assert(firstElement==2 and success,"GetFirstTestCase failed");

      (success,list.numberOfElements,list.elements):=remove(list,1);
      (success,firstElement):=getFirst(list);
      assert(not
                (success),"GetFirstTestCase failed");

      when (terminal()) then
        Modelica.Utilities.Streams.print("GetFirstTestCase passed");
      end when;

    end GetFirstTestCase;

    model GetTestCase
      import List.*;
      List list(size=3);
      Integer element;
      Boolean success;
    algorithm

      //Create a list with size 10 and two stored elements {1,2}
      (list.numberOfElements,list.elements):=testSetup();

      (success,element):=get(list, 1);
      assert(element==1 and success,"GetTestCase failed");

      (success,element):=get(list, 2);
      assert(element==2 and success,"GetTestCase failed");

      (success,list.numberOfElements,list.elements):=remove(list,1);
      (success,list.numberOfElements,list.elements):=remove(list,1);

      (success,element):=get(list, 1);
      assert(not
                (success),"GetTestCase failed");

      when (terminal()) then
        Modelica.Utilities.Streams.print("GetTestCase passed");
      end when;

    end GetTestCase;

    model RemoveTestCase
      import List.*;
      List list(size=3);
      Boolean success;
    algorithm

      //Create a list with size 10 and two stored elements {1,2}
      (list.numberOfElements,list.elements):=testSetup();

      (success,list.numberOfElements,list.elements):=remove(list,1);
      assert(success,"RemoveTestCase failed");
      (success,list.numberOfElements,list.elements):=remove(list,1);
      assert(success,"RemoveTestCase failed");
      (success,list.numberOfElements,list.elements):=remove(list,1);
      assert(not
                (success),"RemoveTestCase failed");

      when (terminal()) then
        Modelica.Utilities.Streams.print("RemoveTestCase passed");
      end when;

    end RemoveTestCase;

    model IsEmptyTestCase
      import List.*;
      List list(size=3);
      Boolean success;
      Boolean isEmptyResult;

    algorithm
      //Create a list with size 10 and two stored elements {1,2}
      (list.numberOfElements,list.elements):=testSetup();

      (success,list.numberOfElements,list.elements):=remove(list,1);
      isEmptyResult:=isEmpty(list);
      assert(not
                (isEmptyResult),"IsEmptyTestCase failed");

      (success,list.numberOfElements,list.elements):=remove(list,1);
      isEmptyResult:=isEmpty(list);
      assert(isEmptyResult,"IsEmptyTestCase failed");

      when (terminal()) then
        Modelica.Utilities.Streams.print("IsEmptyTestCase passed");
      end when;

    end IsEmptyTestCase;

    model InsertTestCase
      import List.*;
      List list(size=3);
      Integer firstElement;
      Integer element;
    algorithm

      //Create a list with size 10 and two stored elements {1,2}
      (list.numberOfElements,list.elements):=testSetup();

      (,list.numberOfElements,list.elements):=insert(list,1,3);

      assert(contains(list,3),"InsertTestCase failed");

      (,firstElement):=getFirst(list);
      assert(firstElement==3,"InsertTestCase failed");

      (,element):=get(list,2);
      assert(element==1,"InsertTestCase failed");

      (,element):=get(list,3);
      assert(element==2,"InsertTestCase failed");

      (,list.numberOfElements,list.elements):=insert(list,3,4);

      assert(not
                (contains(list,4)),"InsertTestCaseFailed");

      when (terminal()) then
        Modelica.Utilities.Streams.print("InsertTestCase passed");
      end when;

    end InsertTestCase;

    function testSetup "Helper function to setup a list with elements"
      import List.*;

      output Integer numberOfElements=2;
      output Integer elements[3];

    algorithm
      elements[1]:=1;
      elements[2]:=2;

    end testSetup;
  end UnitTests;
  annotation (uses(Modelica(version="2.2.2")));
  package FunctionalTests
  end FunctionalTests;
end List;
