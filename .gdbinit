# __________________gdb options_________________

# set to 0 if you have problems with the colorized prompt - reported by Plouj with Ubuntu gdb 7.2
set $COLOREDPROMPT = 1
# color the first line of the disassembly - default is green, if you want to change it search for
# SETCOLOR1STLINE and modify it :-)
set $SETCOLOR1STLINE = 0
# set to 0 to remove display of objectivec messages (default is 1)
set $SHOWOBJECTIVEC = 1
# set to 0 to remove display of cpu registers (default is 1)
set $SHOWCPUREGISTERS = 1
# set to 1 to enable display of stack (default is 0)
set $SHOWSTACK = 0
# set to 1 to enable display of data window (default is 0)
set $SHOWDATAWIN = 0
# set to 0 to disable colored display of changed registers
set $SHOWREGCHANGES = 1
# set to 1 so skip command to execute the instruction at the new location
# by default it EIP/RIP will be modified and update the new context but not execute the instruction
set $SKIPEXECUTE = 1
# if $SKIPEXECUTE is 1 configure the type of execution
# 1 = use stepo (do not get into calls), 0 = use stepi (step into calls)
set $SKIPSTEP = 0
# show the ARM opcodes - change to 0 if you don't want such thing (in x/i command)
set $ARMOPCODES = 1
# x86 disassembly flavor: 0 for Intel, 1 for AT&T
set $X86FLAVOR = 0
# use colorized output or not
set $USECOLOR = 1
# to use with remote KDP
set $KDP64BITS = -1
set $64BITS = 0

set history filename ~/.gdb_history
set history save

# These make gdb never pause in its output
set height 0
set width 0

set $SHOW_CONTEXT = 1
set $SHOW_NEST_INSN = 0

set $CONTEXTSIZE_STACK = 6
set $CONTEXTSIZE_DATA  = 8
set $CONTEXTSIZE_CODE  = 8

# __________________end gdb options_________________
#

# ______________window size control___________
define contextsize-stack
    if $argc != 1
        help contextsize-stack
    else
        set $CONTEXTSIZE_STACK = $arg0
    end
end
document contextsize-stack
Syntax: contextsize-stack NUM
| Set stack dump window size to NUM lines.
end


define contextsize-data
    if $argc != 1
        help contextsize-data
    else
        set $CONTEXTSIZE_DATA = $arg0
    end
end
document contextsize-data
Syntax: contextsize-data NUM
| Set data dump window size to NUM lines.
end


define contextsize-code
    if $argc != 1
        help contextsize-code
    else
        set $CONTEXTSIZE_CODE = $arg0
    end
end
document contextsize-code
Syntax: contextsize-code NUM
| Set code window size to NUM lines.
end


# _____________breakpoint aliases_____________
define bpl
    info breakpoints
end
document bpl
Syntax: bpl
| List all breakpoints.
end


define bp
    if $argc != 1
        help bp
    else
        break $arg0
    end
end
document bp
Syntax: bp LOCATION
| Set breakpoint.
| LOCATION may be a line number, function name, or "*" and an address.
| To break on a symbol you must enclose symbol name inside "".
| Example:
| bp "[NSControl stringValue]"
| Or else you can use directly the break command (break [NSControl stringValue])
end


define bpc 
    if $argc != 1
        help bpc
    else
        clear $arg0
    end
end
document bpc
Syntax: bpc LOCATION
| Clear breakpoint.
| LOCATION may be a line number, function name, or "*" and an address.
end


define bpe
    if $argc != 1
        help bpe
    else
        enable $arg0
    end
end
document bpe
Syntax: bpe NUM
| Enable breakpoint with number NUM.
end


define bpd
    if $argc != 1
        help bpd
    else
        disable $arg0
    end
end
document bpd
Syntax: bpd NUM
| Disable breakpoint with number NUM.
end


define bpt
    if $argc != 1
        help bpt
    else
        tbreak $arg0
    end
end
document bpt
Syntax: bpt LOCATION
| Set a temporary breakpoint.
| This breakpoint will be automatically deleted when hit!.
| LOCATION may be a line number, function name, or "*" and an address.
end


define bpm
    if $argc != 1
        help bpm
    else
        awatch $arg0
    end
end
document bpm
Syntax: bpm EXPRESSION
| Set a read/write breakpoint on EXPRESSION, e.g. *address.
end


define bhb
    if $argc != 1
        help bhb
    else
        hb $arg0
    end
end
document bhb
Syntax: bhb LOCATION
| Set hardware assisted breakpoint.
| LOCATION may be a line number, function name, or "*" and an address.
end


define bht
    if $argc != 1
        help bht
    else
        thbreak $arg0
    end
end
document bht
Usage: bht LOCATION
| Set a temporary hardware breakpoint.
| This breakpoint will be automatically deleted when hit!
| LOCATION may be a line number, function name, or "*" and an address.
end


# ______________process information____________
define argv
    show args
end
document argv
Syntax: argv
| Print program arguments.
end


define stack
    if $argc == 0
        info stack
    end
    if $argc == 1
        info stack $arg0
    end
    if $argc > 1
        help stack
    end
end
document stack
Syntax: stack <COUNT>
| Print backtrace of the call stack, or innermost COUNT frames.
end

define locals
    info locals
end
document locals
Syntax: locals
| Print local variables.
end


define frame
    info frame
    info args
    info locals
end
document frame
Syntax: frame
| Print stack frame.
end

set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set demangle-style gnu-v3
set print sevenbit-strings off
set output-radix 10
set radix 10

#EOF
