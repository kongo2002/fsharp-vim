" Vim syntax file
" Language:     F#
" Filenames:    *.fs *.fsi *.fsx
" Maintainers:  Thomas Schank <ThomasSchank@gmail.com>
"               Gregor Uhlenheuer <kongo2002@googlemail.com>
" Notes:        based on Choy Rims first version of fs.vim


if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif


" F# is case sensitive.
syn case match


" Scripting directives
syn match    fsScript "^#\<\(quit\|labels\|warnings\|directory\|cd\|load\|use\|install_printer\|remove_printer\|require\|thread\|trace\|untrace\|untrace_all\|print_depth\|print_length\)\>"


" C# style comments
syn match    fsComment "//.*$" contains=@fsCommentHook,fsTodo,@Spell


" errors
syn match    fsBraceErr   "}"
syn match    fsBrackErr   "\]"
syn match    fsParenErr   ")"
syn match    fsArrErr     "|]"

syn match    fsCommentErr "\*)"


" enclosing delimiters
syn region   fsEncl transparent matchgroup=fsKeyword start="(" matchgroup=fsKeyword end=")" contains=ALLBUT,@fsContained,fsParenErr
syn region   fsEncl transparent matchgroup=fsKeyword start="{" matchgroup=fsKeyword end="}"  contains=ALLBUT,@fsContained,fsBraceErr
syn region   fsEncl transparent matchgroup=fsKeyword start="\[" matchgroup=fsKeyword end="\]" contains=ALLBUT,@fsContained,fsBrackErr
syn region   fsEncl transparent matchgroup=fsKeyword start="\[|" matchgroup=fsKeyword end="|\]" contains=ALLBUT,@fsContained,fsArrErr


" comments
syn region   fsComment start="(\*" end="\*)" contains=fsComment,fsTodo
syn keyword  fsTodo contained TODO FIXME XXX NOTE

" keywords
syn keyword fsKeyword    abstract and as assert begin class default delegate
syn keyword fsKeyword    do done downcast downto else end
syn keyword fsKeyword    enum exception extern false finally for fun function
syn keyword fsKeyword    if in inherit interface land lazy let
syn keyword fsKeyword    match member  module mutable namespace new null of
syn keyword fsKeyword    open or override rec sig static struct then to true
syn keyword fsKeyword    try type val when inline upcast while with void
syn keyword fsKeyword    async atomic break checked component const constraint
syn keyword fsKeyword    constructor continue decimal eager event
syn keyword fsKeyword    external fixed functor include method mixin object
syn keyword fsKeyword    process property protected public pure readonly return sealed
syn keyword fsKeyword    yield virtual volatile

" modifiers
syn keyword fsModifier   abstract const extern internal override private
syn keyword fsModifier   protected public readonly sealed static virtual
syn keyword fsModifier   volatile

" constants
syn keyword fsConstant   false null true

" types
syn keyword  fsType      array bool char exn float format format4
syn keyword  fsType      int int32 int64 lazy_t list nativeint option
syn keyword  fsType      string unit

" options
syn keyword  fsOption    Some None

" operators
syn keyword  fsOperator  asr lor lsl lsr lxor mod not land

" Module prefix
syn match    fsModPath      "\u\(\w\|'\)*\."he=e-1

syn match    fsCharacter    "'\\\d\d\d'\|'\\[\'ntbr]'\|'.'"
syn match    fsCharErr      "'\\\d\d'\|'\\\d'"
syn match    fsCharErr      "'\\[^\'ntbr]'"
syn region   fsString       start=+"+ skip=+\\\\\|\\"+ end=+"+

syn match    fsFunDef       "->"
syn match    fsRefAssign    ":="
syn match    fsTopStop      ";;"
syn match    fsOperator     "\^"
syn match    fsOperator     "::"

syn match    fsOperator     "&&"
syn match    fsOperator     "<"
syn match    fsOperator     ">"
syn match    fsOperator     "|>"
syn match    fsOperator     ":>"
syn match    fsOperator     ":?>"
syn match    fsOperator     "&&&"
syn match    fsOperator     "|||"
syn match    fsOperator     "\.\."

syn match    fsAnyVar       "\<_\>"
syn match    fsKeyChar      "|[^\]]"me=e-1
syn match    fsKeyChar      ";"
syn match    fsKeyChar      "\~"
syn match    fsKeyChar      "?"
syn match    fsKeyChar      "\*"
syn match    fsKeyChar      "+"
syn match    fsKeyChar      "="
syn match    fsKeyChar      "|"

syn match    fsOperator     "<-"

syn match    fsNumber        "\v\d+"
syn match    fsNumber        "\<-\=\d\(_\|\d\)*[l|L|n]\?\>"
syn match    fsNumber        "\<-\=0[x|X]\(\x\|_\)\+[l|L|n]\?\>"
syn match    fsNumber        "\<-\=0[o|O]\(\o\|_\)\+[l|L|n]\?\>"
syn match    fsNumber        "\<-\=0[b|B]\([01]\|_\)\+[l|L|n]\?\>"
syn match    fsFloat         "\<-\=\d\(_\|\d\)*\.\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"
syn match    fsFloat         "\<-\=\d\(_\|\d\)*\.\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"
syn match    fsFloat         "\v\d+\.\d*"


" preprocessor directives
syn region   fsPreCondit
            \ start="^\s*#\s*\(define\|undef\|if\|elif\|else\|endif\|line\|error\|warning\|light\)"
                \ skip="\\$" end="$" contains=fsComment keepend
syn region   fsRegion matchgroup=fsPreCondit start="^\s*#\s*region.*$"
            \ end="^\s*#\s*endregion" transparent fold contains=TOP


if version >= 508 || !exists("did_fs_syntax_inits")
    if version < 508
        let did_fs_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink fsBraceErr      Error
    HiLink fsBrackErr      Error
    HiLink fsParenErr      Error
    HiLink fsArrErr        Error

    HiLink fsCommentErr    Error

    HiLink fsCountErr      Error
    HiLink fsDoErr         Error
    HiLink fsDoneErr       Error
    HiLink fsEndErr        Error
    HiLink fsThenErr       Error

    HiLink fsCharErr       Error

    HiLink fsErr           Error

    HiLink fsComment       Comment

    HiLink fsModPath       Include
    HiLink fsObject        Include
    HiLink fsModule        Include
    HiLink fsModParam1     Include
    HiLink fsModType       Include
    HiLink fsMPRestr3      Include
    HiLink fsFullMod       Include
    HiLink fsModTypeRestr  Include
    HiLink fsWith          Include
    HiLink fsMTDef         Include

    HiLink fsScript        Include

    HiLink fsConstructor   Constant

    HiLink fsModPreRHS     Keyword
    HiLink fsMPRestr2      Keyword
    HiLink fsKeyword       Keyword
    HiLink fsMethod        Include
    HiLink fsFunDef        Keyword
    HiLink fsRefAssign     Keyword
    HiLink fsAnyVar        Keyword
    HiLink fsTopStop       Keyword
    HiLink fsKeyChar       Operator
    HiLink fsOperator      Operator

    HiLink fsBoolean       Boolean
    HiLink fsCharacter     Character
    HiLink fsNumber        Number
    HiLink fsFloat         Float
    HiLink fsString        String

    HiLink fsLabel         Identifier

    HiLink fsType          Type

    HiLink fsTodo          Todo

    HiLink fsEncl          Keyword

    delcommand HiLink
endif

let b:current_syntax = "fsharp"

" vim: sw=4 et sts=4
