#!/bin/bash

# Logging Helper Functions
# This file provides standardized logging functions for all scripts

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Log levels (lower number = higher priority)
LOG_LEVEL_ERROR=1
LOG_LEVEL_SUCCESS=1
LOG_LEVEL_WARN=2
LOG_LEVEL_INFO=3
LOG_LEVEL_DEBUG=4

# Default log level (can be overridden by setting LOG_LEVEL environment variable)
LOG_LEVEL=${LOG_LEVEL:-$LOG_LEVEL_WARN}

# Function to check if message should be logged
should_log() {
    local message_level=$1
    [ "$message_level" -le "$LOG_LEVEL" ]
}

# Function to set log level from string
set_log_level() {
    case "$1" in
        "error"|"ERROR")
            export LOG_LEVEL=$LOG_LEVEL_ERROR
            ;;
        "warn"|"WARN"|"warning"|"WARNING")
            export LOG_LEVEL=$LOG_LEVEL_WARN
            ;;
        "info"|"INFO")
            export LOG_LEVEL=$LOG_LEVEL_INFO
            ;;
        "debug"|"DEBUG")
            export LOG_LEVEL=$LOG_LEVEL_DEBUG
            ;;
        *)
            log_error "Invalid log level: $1. Valid levels: error, warn, info, debug"
            return 1
            ;;
    esac
}

# Logging functions
log_info() {
    if should_log $LOG_LEVEL_INFO; then
        echo -e "${GREEN}[INFO]${NC} $1"
    fi
}

log_warn() {
    if should_log $LOG_LEVEL_WARN; then
        echo -e "${YELLOW}[WARN]${NC} $1"
    fi
}

log_error() {
    if should_log $LOG_LEVEL_ERROR; then
        echo -e "${RED}[ERROR]${NC} $1"
    fi
}

log_debug() {
    if should_log $LOG_LEVEL_DEBUG; then
        echo -e "${BLUE}[DEBUG]${NC} $1"
    fi
}

# Success/failure functions
log_success() {
    if should_log $LOG_LEVEL_SUCCESS; then
        echo -e "${GREEN}[SUCCESS]${NC} $1"
    fi
}

log_fail() {
    if should_log $LOG_LEVEL_ERROR; then
        echo -e "${RED}[FAIL]${NC} $1"
    fi
}
