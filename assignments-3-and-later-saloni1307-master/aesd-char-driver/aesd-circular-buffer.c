/**
 * @file aesd-circular-buffer.c
 * @brief Functions and data related to a circular buffer imlementation
 *
 * @author Dan Walkes
 * @date 2020-03-01
 * @copyright Copyright (c) 2020
 *
 */

#ifdef __KERNEL__
#include <linux/string.h>
#include <linux/slab.h>
#else
#include <string.h>
#include <stdlib.h>
#endif

#include "aesd-circular-buffer.h"

/**
 * @param buffer the buffer to search for corresponding offset.  Any necessary locking must be performed by caller.
 * @param char_offset the position to search for in the buffer list, describing the zero referenced
 *      character index if all buffer strings were concatenated end to end
 * @param entry_offset_byte_rtn is a pointer specifying a location to store the byte of the returned aesd_buffer_entry
 *      buffptr member corresponding to char_offset.  This value is only set when a matching char_offset is found
 *      in aesd_buffer. 
 * @return the struct aesd_buffer_entry structure representing the position described by char_offset, or
 * NULL if this position is not available in the buffer (not enough data is written).
 */
struct aesd_buffer_entry *aesd_circular_buffer_find_entry_offset_for_fpos(struct aesd_circular_buffer *buffer,
                                                                          size_t char_offset, size_t *entry_offset_byte_rtn)
{
    //get current entry position in the circular buffer
    uint8_t entry_position = buffer->out_offs;
    //get size of that entry
    size_t size_of_buffptr = buffer->entry[entry_position].size;
    //variable to store size of all previous entries
    int total_entry = 0;

    //check if the buffer is empty
    if (buffer == NULL)
    {
        return NULL;
    }
    /*if (buffer->out_offs == buffer->in_offs && (!buffer->full))
    {
        return NULL;
    }*/

    //traverse the buffer until you reach end of buffer or you find the character position
    do
    {
        //if the character position is not in present entry
        if (char_offset >= size_of_buffptr)
        {
            //store the size of all previous entries
            total_entry = size_of_buffptr;
            //go to next entry in circular buffer
            entry_position = (entry_position + 1) % AESDCHAR_MAX_WRITE_OPERATIONS_SUPPORTED;
            /*entry_position++;
            if (entry_position >= AESDCHAR_MAX_WRITE_OPERATIONS_SUPPORTED)
            {
                entry_position = 0;
            }*/
            //get size of all entries traversed
            size_of_buffptr += buffer->entry[entry_position].size;
        }
        //if character position is in present entry
        else
        {
            //get the position of the character
            *entry_offset_byte_rtn = char_offset - total_entry;
            //return entry struct
            return (&(buffer->entry[entry_position]));
        }
    } while (entry_position != buffer->in_offs);
    return NULL;
}

/**
* Adds entry @param add_entry to @param buffer in the location specified in buffer->in_offs.
* If the buffer was already full, overwrites the oldest entry and advances buffer->out_offs to the
* new start location.
* Any necessary locking must be handled by the caller
* Any memory referenced in @param add_entry must be allocated by and/or must have a lifetime managed by the caller.
*/
const char *aesd_circular_buffer_add_entry(struct aesd_circular_buffer *buffer, const struct aesd_buffer_entry *add_entry)
{
    const char *return_ptr = NULL;

    if (buffer == NULL || add_entry == NULL)
    {
        return return_ptr;
    }
    if (buffer->full)
    {
        return_ptr = buffer->entry[buffer->in_offs].buffptr;
    }

    //advance out offset also if buffer is full

    //add entry in the circular buffer
    buffer->entry[buffer->in_offs] = *add_entry;

    //advance to next position
    //buffer->in_offs++;
    buffer->in_offs = (buffer->in_offs + 1) % AESDCHAR_MAX_WRITE_OPERATIONS_SUPPORTED;

    if (buffer->full)
    {
        //buffer->out_offs++;
        buffer->out_offs = (buffer->out_offs + 1) % AESDCHAR_MAX_WRITE_OPERATIONS_SUPPORTED;
    }

    //check if buffer is full
    if (buffer->in_offs == buffer->out_offs)
        buffer->full = true;
    else
        buffer->full = false;

    return return_ptr;
}

/**
* Initializes the circular buffer described by @param buffer to an empty struct
*/
void aesd_circular_buffer_init(struct aesd_circular_buffer *buffer)
{
    memset(buffer, 0, sizeof(struct aesd_circular_buffer));
}

void aesd_cicular_buffer_free(struct aesd_circular_buffer *buffer)
{
    uint8_t index;
    struct aesd_buffer_entry *entry;

    AESD_CIRCULAR_BUFFER_FOREACH(entry, buffer, index)
    {

        if (entry->buffptr != NULL)
        {

#ifdef __KERNEL__
            kfree(entry->buffptr);

#else
            free((char *)entry->buffptr);

#endif
        }
    }
}