package Queueing "Package that provides Modelica classes for queueing"
  record Queue
    "Data structure of a FIFO queue for Integer elements with limited capacity"
    parameter Integer size "The capacity of the queue.";
    Integer numberOfElements(start=0)
      "The number of elements currently stored in the queue.";
    Integer elements[size] "The Integer array storing the Integer values.";
  end Queue;

  function enqueue "function to enqeue an element in a queue"
    input Queue queue "The queue in which the element is enqueued";
    input Integer element "The element to enqueue";
    output Boolean successful
      "true: value was enqueued, false: value was not enqueue becaus queue is full";

    output Integer numberOfElements;
    output Integer elements[queue.size];

  protected
  Queue resultQueue(size=queue.size,numberOfElements=queue.numberOfElements,elements=queue.elements)
      "the queue where the element was enqueued (or not)";

  algorithm
    if (resultQueue.numberOfElements<resultQueue.size) then
      resultQueue.elements[resultQueue.numberOfElements+1]:=element;
      resultQueue.numberOfElements:=resultQueue.numberOfElements + 1;
      successful:=true;
    else
      successful:=false;
    end if;

    numberOfElements:=resultQueue.numberOfElements;
    elements:=resultQueue.elements;

  end enqueue;
  annotation (uses(Modelica(version="2.2.1")));
  function dequeue "function to dequeue a value from the queue"
    input Queue queue "the queue to queue from";
    output Boolean successful
      "true: element could be successfully dequeued, false: no element was dequeued because queue is empty";
    output Integer element "the dequeued element";
    output Integer numberOfElements "new position of the queue";
    output Integer elements[queue.size] "new list of elements in the queue";
  protected
    Queue resultQueue=Queue(size=queue.size,numberOfElements=queue.numberOfElements, elements=queue.elements)
      "the queue without the dequeued element";
  algorithm

    if (resultQueue.numberOfElements>0) then

      element:=resultQueue.elements[1];

      //shift all elements forward
      for i in 2:resultQueue.numberOfElements loop
        resultQueue.elements[i-1]:=resultQueue.elements[i];
      end for;

      resultQueue.numberOfElements:=resultQueue.numberOfElements-1;
      successful:=true;
    else
      successful:=false;
    end if;

    numberOfElements:=resultQueue.numberOfElements;
    elements:=resultQueue.elements;
  end dequeue;

  function getFirst "function to get the first element without dequeueing"
    input Queue queue "the queue to read the first element from";
    output Boolean successful
      "true: reading was successful, false: queue is empty";
    output Integer element "the first element in the queue";
  algorithm
    if (not
           (Queueing.isEmpty(
                  queue))) then
      element:=queue.elements[1];
      successful:=true;
    else
      element:=0;
      successful:=false;
    end if;
  end getFirst;

  function contains
    "function to retrieve if the queue contains a  certain element"
    input Queue queue "The queue to check for the element";
    input Integer element "The element to be checked";
    output Boolean result
      "true: the queue contains the element, false: the queue does not contain the element";
  algorithm

    result:=false;

    for i in 1:queue.numberOfElements loop
      if (queue.elements[i]==element) then
        result:=true;
      end if;
    end for;
  end contains;

  function isEmpty "function to query if the task is empty"
    input Queue queue "the queue to check for emptiness";
    output Boolean result "true: queue is empty, false: queue is not empty";

  algorithm
    if (queue.numberOfElements==0) then
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
end Queueing;
