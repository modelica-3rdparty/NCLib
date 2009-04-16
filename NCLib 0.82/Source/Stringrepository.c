/*Stringrepository library defines a linklist to manage the strings. It consists of three basic functions:
long createmessage( char* message)
void deleteMessage(long messageID)
const char* readMessage(long messageID)
and a definition of the link element structure.*/

#pragma   once

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "ModelicaUtilities.h"


struct messageElement    //structure element definition for a link list
{
	char * messageContent;  // pointer to a string
	long counter;        // The identifier for the message
	struct messageElement *next;  // next element
} ;

typedef struct messageElement message;  //Declaration
typedef message *messagePointer;

messagePointer HEAD=NULL;  //Initialization
long messageID=0;

long createmessage( char* inputmessage)   // Store message and return the unique identifier
{
   messagePointer NEW;   //create a new message element
   messagePointer Actual;

   NEW= (messagePointer)  malloc (sizeof(message));
   NEW->messageContent = (char*) malloc(strlen(inputmessage)+1);
   strcpy(NEW->messageContent,inputmessage);  // store the input string to the created message element
   messageID ++;
   NEW->counter = messageID;  // give a unique message identifier (global variable)
   NEW->next=NULL;


   if (HEAD==NULL)   // add the created message element to the message list.

	{
	HEAD=NEW;   // if no message element in the list, the new one is the head element.
	}
	else    // add to the end of the list.
	{

	Actual=HEAD;
	while (Actual->next!=NULL)
			{
				Actual=Actual->next;
			}
	Actual->next=NEW;
	}
	return NEW->counter;  // return the message identifier

}


void deletemessage(long messageID)  // Find the message element with given message identifier, release the memory and reconstruct the list.
{
	messagePointer Actual;
	messagePointer left;
	Actual=HEAD;

while(Actual!=NULL)
	{
	if (Actual->counter==messageID)
		{
			if (Actual==HEAD)
			{
				HEAD=Actual->next;   //  it the to be deleted message element is the head of the list, set the head to the next element

			}
			else                    // let the previous element point to the over next element, and delete the selected one.
			{
				left=HEAD;
			  while (left!=NULL)

			  {
				  if (left->next==Actual)
				  {
					  left->next=Actual->next;
					  break;
				  }
				  left=left->next;
			  }
			 }
		  free(Actual->messageContent);  // release the memory for the string
		  free(Actual);  // release the memory for the structure
		  break;
		 }
	Actual=Actual->next;
	}

}
 char* readmessage(long messageID)  // return the corresponding message content,
{
   	  char * outputstr;
	  messagePointer Actual;
	  Actual=HEAD;
	 while (Actual !=NULL)
	 {
		 if (Actual->counter==messageID)
		  {
			 outputstr=ModelicaAllocateString(strlen(Actual->messageContent)+1);
			 strcpy(outputstr,Actual->messageContent);
			 break;
		  }

		 Actual=Actual->next;

	 }
return outputstr;

}
