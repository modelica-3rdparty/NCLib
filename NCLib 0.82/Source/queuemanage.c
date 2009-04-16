#pragma   once

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>


#include "Stringrepository.h"

// use linked list for the caches in order to feed back the cache ID in a integer number and allows the search of arbitrary cache.
// A cache element defined in the list is show as the structure below.

struct cache  //use this structure to represent the Message queue in Dymola, Cache_ID represents the beginning address of the queue, and index represents the free place to insert
{ int * pCache;  //here the address of the reserved memory block,
  int index;   //the actual index of the cache
  int cacheSize;  // stati: properti of the cache
  int cacheID;  // the return value which represents the unique ID of the cache
  struct cache * next;
};
struct cache *head=NULL;
int iCacheID=0;  // global variable: the cache identifier.


int reservememory( int cacheSize)
{
	int i;
	struct cache * actual;

    struct cache *newcache= malloc(sizeof(struct cache));  // allocate the memory for the new cache element
	newcache->pCache=(int *) malloc (cacheSize* sizeof(long));  // allocate the memory for the cache array in the cache element.

	//Reserve memory for the cache in one Modelica Block. The addresses of reserved places are return values.  To ensure a stable
	//performance in the simulation , these memory blocks will not be released, but only be rewritten.
	for (i=0;i<cacheSize;i++)
	{
		newcache->pCache[i]=-1;   // initialization with invalid memory address.
	}

	newcache->index=0;            // initiallization of the cache element.
	newcache->cacheSize=cacheSize;
	newcache->cacheID=iCacheID;
	newcache->next=NULL;

	iCacheID++;   // The global variable increment for the next cache.

	if (head==NULL)
		head=newcache;   // if there is no cache defined before, this cache as the header of the cache lists.
	else    // if there is already other caches defined in the list. add this new one at the end
		{
			actual=head;
			while (actual->next!=NULL)
			{
				actual=actual->next;
			}
			actual->next=newcache;
		}

	return newcache->cacheID;   // Return the cache identifier

}
void enqueue(int cacheID, long messageID)
// Add the messageID to the cache, find the free available storage place.
{

	struct cache *actual;
	actual=head;
	while (actual!=NULL)   //search for the cache in cachelist
	{
		if (actual->cacheID==cacheID)  // find out the selected cache
		{
				if (actual->index<actual->cacheSize)  // if there is free storage place
				{
					actual->pCache[actual->index]=createmessage(readmessage(messageID));  // store the copy of Message
					actual->index++;  // the actual index of the cache increate by 1.
					deletemessage(messageID);   // release the memory consume of the old message
				}
				else if (actual->index>=actual->cacheSize)   // if cache is full , do nothing
					actual->index=actual->cacheSize;
		break;
		}
	actual=actual->next;
	}



}


long dequeue(int cacheID)
// Dequeue the first message from the selected cache
{
	int i;
	long outputMessageID;

	struct cache *actual;
	actual=head;
	while (actual!=NULL)
	{
		if (actual->cacheID==cacheID)  // find the cache from the cache list
		{
			if (actual->index>0)  // if the cache is not empty
			{
				outputMessageID=createmessage(readmessage(actual->pCache[0]));  // make a copy of the first message
				deletemessage(actual->pCache[0]); // delete the first message
					if (actual->index>1)   // if there are more than 2 messages in the cache, right shift the whole entries to the beginn of 1 position
					{
						for (i=1;i<actual->index;i++)
						{
						actual->pCache[i-1]=actual->pCache[i];
						}
					}
				actual->index--; // set new pointer to the available storage place
			}
			else // if the cache is empty, return NULL
				outputMessageID=createmessage("NULL");
		break;
		}

	actual=actual->next;

	}
	return outputMessageID;

}


int readcacheindex(int cacheID)

// return the actual index of the selected cache.
{
	struct cache * actual;
	actual=head;
	while (actual!=NULL)
		{
				if(actual->cacheID==cacheID)
				{
					break;
				}
			actual=actual->next;
		}

	return (int) actual->index;
}

