" Vim syntax file
" Language:     F#
" Last Change:  Tue 05 Jun 2012 01:28:41 AM CEST
" Maintainer:   Gregor Uhlenheuer <kongo2002@googlemail.com>
"
" Note:         This syntax file is a complete rewrite of the original version
"               of fs.vim from Choy Rim <choy.rim@gmail.com> and a slight
"               modified version from Thomas Schank <ThomasSchank@gmail.com>

if version < 600
    syntax clear
elseif exists('b:current_syntax')
    finish
endif

" F# is case sensitive.
syn case match

" reset 'iskeyword' setting
setl isk&vim

" Scripting/preprocessor directives
syn match    fsSScript "^\s*#\S\+" transparent contains=fsScript,fsRegion,fsPreCondit

syn match    fsScript contained "#"
syn keyword  fsScript contained quitlabels warnings directory cd load use
syn keyword  fsScript contained install_printer remove_printer requirethread
syn keyword  fsScript contained trace untrace untrace_all print_depth
syn keyword  fsScript contained print_length define undef if elif else endif
syn keyword  fsScript contained line error warning light nowarn


" comments
syn match    fsComment "//.*$" contains=fsTodo,@Spell
syn region   fsDocComment start="///" end="$" contains=fsTodo,fsXml,@Spell keepend oneline
syn region   fsXml matchgroup=fsXmlDoc start="<[^>]\+>" end="</[^>]\+>" contained


" symbol names
syn match fsSymbol "\%(let\|use\|mutable\|rec\)\@<=!\=\s*\zs\w\+\ze\s*[^=:]*[=:]"
syn match fsSymbol "\%(member\)\@<=\s\+\w\+\.\zs\w\+"


" types
syn match    fsTypeName   "\%(\<type\s\+\)\@<=\w\+"


" errors
syn match    fsBraceErr   "}"
syn match    fsBrackErr   "\]"
syn match    fsParenErr   ")"
syn match    fsArrErr     "|]"
syn match    fsCommentErr "\*)"


" enclosing delimiters
syn region   fsEncl transparent matchgroup=fsKeyword start="(" matchgroup=fsKeyword end=")" contains=ALLBUT,fsParenErr,fsScript
syn region   fsEncl transparent matchgroup=fsKeyword start="{" matchgroup=fsKeyword end="}"  contains=ALLBUT,fsBraceErr,fsScript
syn region   fsEncl transparent matchgroup=fsKeyword start="\[" matchgroup=fsKeyword end="\]" contains=ALLBUT,fsBrackErr,fsScript
syn region   fsEncl transparent matchgroup=fsKeyword start="\[|" matchgroup=fsKeyword end="|\]" contains=ALLBUT,fsArrErr,fsScript


" comments
syn region   fsComment start="(\*" end="\*)" contains=fsComment,fsTodo
syn keyword  fsTodo contained TODO FIXME XXX NOTE

" keywords
syn keyword fsKeyword    abstract as assert base begin class default delegate
syn keyword fsKeyword    do done downcast downto elif else end exception
syn keyword fsKeyword    extern for fun function global if in inherit inline
syn keyword fsKeyword    interface lazy let match member module mutable
syn keyword fsKeyword    namespace new of override rec static struct then
syn keyword fsKeyword    to type upcast val void when while with

syn keyword fsKeyword    async atomic break checked component const constraint
syn keyword fsKeyword    constructor continue decimal eager event external
syn keyword fsKeyword    fixed functor include method mixin object process
syn keyword fsKeyword    property pure return seq tailcall trait

" additional operator keywords (Microsoft.FSharp.Core.Operators)
syn keyword fsKeyword    box hash sizeof typeof typedefof unbox ref fst snd
syn keyword fsKeyword    stdin stdout stderr

" math operators (Microsoft.FSharp.Core.Operators)
syn keyword fsKeyword    abs acos asin atan atan2 ceil cos cosh exp floor log
syn keyword fsKeyword    log10 pown round sign sin sinh sqrt tan tanh

syn keyword fsOCaml      asr land lor lsl lsr lxor mod sig

if !exists('g:fsharp_no_linq') || g:fsharp_no_linq == 0
    syn keyword fsLinq   orderBy select where yield
endif

" open
syn keyword fsOpen       open

" exceptions
syn keyword fsException  try failwith failwithf finally invalid_arg raise
syn keyword fsException  rethrow

" modifiers
syn keyword fsModifier   abstract const extern internal override private
syn keyword fsModifier   protected public readonly sealed static virtual
syn keyword fsModifier   volatile

" constants
syn keyword fsConstant   null
syn keyword fsBoolean    false true

" types
syn keyword  fsType      array bool byte char decimal double enum exn float
syn keyword  fsType      float32 int int16 int32 int64 lazy_t list nativeint
syn keyword  fsType      obj option sbyte single string uint uint32 uint64
syn keyword  fsType      unativeint unit

" core classes
syn match    fsCore      "\u\a*\." transparent contains=fsCoreClass

syn keyword  fsCoreClass Array Async Directory File List Option Path contained
syn keyword  fsCoreClass String Seq Tuple contained

syn keyword fsCoreMethod printf printfn sprintf eprintf eprintfn fprintf
syn keyword fsCoreMethod fprintfn

" options
syn keyword  fsOption    Some None

" operators
syn keyword fsOperator   not and or

syn match    fsCharacter    "'\\\d\d\d'\|'\\[\'ntbr]'\|'.'"
syn match    fsCharErr      "'\\\d\d'\|'\\\d'"
syn match    fsCharErr      "'\\[^\'ntbr]'"
syn region   fsString       start=+"+ skip=+\\\\\|\\"+ end=+"+

syn match    fsFunDef       "->"
syn match    fsRefAssign    ":="
syn match    fsTopStop      ";;"
syn match    fsOperator     "\^"
syn match    fsOperator     "::"

syn match    fsLabel        "\<_\>"

syn match    fsOperator     "&&"
syn match    fsOperator     "<"
syn match    fsOperator     ">"
syn match    fsOperator     "|>"
syn match    fsOperator     ":>"
syn match    fsOperator     ":?>"
syn match    fsOperator     "&&&"
syn match    fsOperator     "|||"
syn match    fsOperator     "\.\."

syn match    fsKeyChar      "|[^\]]"me=e-1
syn match    fsKeyChar      ";"
syn match    fsKeyChar      "\~"
syn match    fsKeyChar      "?"
syn match    fsKeyChar      "\*"
syn match    fsKeyChar      "+"
syn match    fsKeyChar      "="
syn match    fsKeyChar      "|"

syn match    fsOperator     "<-"

syn match    fsNumber        "\<\d\+"
syn match    fsNumber        "\<-\=\d\(_\|\d\)*[l|L|n]\?\>"
syn match    fsNumber        "\<-\=0[x|X]\(\x\|_\)\+[l|L|n]\?\>"
syn match    fsNumber        "\<-\=0[o|O]\(\o\|_\)\+[l|L|n]\?\>"
syn match    fsNumber        "\<-\=0[b|B]\([01]\|_\)\+[l|L|n]\?\>"
syn match    fsFloat         "\<-\=\d\(_\|\d\)*\.\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"
syn match    fsFloat         "\<-\=\d\(_\|\d\)*\.\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"
syn match    fsFloat         "\<\d\+\.\d*"

" modules
syn match    fsModule     "\%(\<open\s\+\)\@<=[a-zA-Z.]\+"

" attributes
syn region   fsAttrib matchgroup=fsAttribute start="\[<" end=">]"

" regions
syn region   fsRegion matchgroup=fsPreCondit start="\%(end\)\@<!region.*$"
            \ end="endregion" fold contains=ALL contained


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

    HiLink fsComment       Comment
    HiLink fsDocComment    Comment
    HiLink fsXml           Comment

    HiLink fsOpen          Include
    HiLink fsModPath       Include
    HiLink fsScript        Include
    HiLink fsPreCondit     Include

    HiLink fsKeyword       Keyword
    HiLink fsCoreMethod    Keyword

    HiLink fsOCaml         Statement
    HiLink fsLinq          Statement

    HiLink fsSymbol        Function

    HiLink fsFunDef        Operator
    HiLink fsRefAssign     Operator
    HiLink fsTopStop       Operator
    HiLink fsKeyChar       Operator
    HiLink fsOperator      Operator

    HiLink fsBoolean       Boolean
    HiLink fsConstant      Constant
    HiLink fsCharacter     Character
    HiLink fsNumber        Number
    HiLink fsFloat         Float
    HiLink fsString        String

    HiLink fsModifier      StorageClass

    HiLink fsException     Exception

    HiLink fsLabel         Identifier
    HiLink fsOption        Identifier
    HiLink fsTypeName      Identifier
    HiLink fsModule        Identifier

    HiLink fsType          Type

    HiLink fsCoreClass     Typedef
    HiLink fsAttrib        Typedef
    HiLink fsXmlDoc        Typedef

    HiLink fsTodo          Todo

    HiLink fsEncl          Delimiter
    HiLink fsAttribute     Delimiter

    delcommand HiLink
endif

let b:current_syntax = 'fsharp'

" vim: sw=4 et sts=4
