#include <stdio.h>

static void (*echo_trace_fn)(void) = NULL;

void echo_register(void (*cb)(void)) 
{
    echo_trace_fn = cb;
}

void echo_trace(void) 
{
    if (echo_trace_fn) 
    {
        echo_trace_fn();  // calls into OCaml!
    } 
}
