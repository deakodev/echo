#include "echo.h"

#include <stdarg.h>
#include <stdio.h>

#define ECHO_MSG_BUF_SIZE 1024

enum Level { Trace = 0, Info, Warn, Error, Fatal, Level_Count };

// Tuple like struct to map Level to echo callback
typedef struct {
  Level level;
  echo_cb cb;
} LevelCallback;

// Registry of callbacks indexed by Level
static LevelCallback level_registry[Level_Count] = {
    {Trace, NULL}, {Info, NULL}, {Warn, NULL}, {Error, NULL}, {Fatal, NULL}};

// Register a callback for a given level
void echo_register(Level level, echo_cb cb) {
  if (level >= 0 && level < Level_Count) {
    level_registry[level].cb = cb;
  } else {
    fprintf(stderr, "[echo_register] Invalid level %d\n", level);
  }
}

// Format and call callback at a given level
static void echo_logf(Level level, const char *fmt, va_list args) {
  char buf[ECHO_MSG_BUF_SIZE];
  vsnprintf(buf, sizeof(buf), fmt, args);

  if (level >= 0 && level < Level_Count && level_registry[level].cb) {
    level_registry[level].cb(buf);
  } else {
    fprintf(stderr, "[echo_vlog] No OCaml callback for level %d: %s\n", level,
            buf);
  }
}

// Pubic variadic c api for logging at different levels
#define DEFINE_ECHO_FN(name, level)                                            \
  void name(const char *fmt, ...) {                                            \
    va_list args;                                                              \
    va_start(args, fmt);                                                       \
    echo_logf(level, fmt, args);                                               \
    va_end(args);                                                              \
  }

DEFINE_ECHO_FN(echo_trace, Trace)
DEFINE_ECHO_FN(echo_info, Info)
DEFINE_ECHO_FN(echo_warn, Warn)
DEFINE_ECHO_FN(echo_error, Error)
DEFINE_ECHO_FN(echo_fatal, Fatal)

void _echo_force_link(void) {}
