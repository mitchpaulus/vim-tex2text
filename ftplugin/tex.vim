function! s:RunTexToText()
    " Store the previous directory to not mess up your workflow
    let previousWorkingDirectory = getcwd()
    let currentFileNameWithExt = expand("%:p")
    let currentFileNameNoExt = expand("%:r")

    let previousARegister = @a
    let previousLastSearch = @/

    " Change to current buffers directory.
    cd %:p:h

    try 
        if !isdirectory("TransformedTexFiles")
            call mkdir("TransformedTexFiles") 
        endif
        cd TransformedTexFiles
    catch
        echom "Could not create TransformedTexFiles directory"
        echom v:exception
        finish
    endtry

    " yank entire file into 'a' register
    %y a
    let newFileName = currentFileNameNoExt . ".txt"

    try 
        call delete(newFileName)
        execute "e " . newFileName 
    catch
        echom "There was an error saving the file."
        echom v:exception
        finish
    endtry

    " Put the contents of the entire file at the beginning of the file.
    1put! a

    setlocal filetype=text
    setlocal noignorecase
    setlocal magic

    let environmentsToDelete = ['landscape','figure','table','equation','multline','array']
    let singleLineCommandsToDelete = ['chapter','section','subsection','subsubsection','usepackage','newcommand','RequirePackage']
    let surroundingCommandsToLeaveInnerText = ['textit','textbf','textsuperscript','textsubscript']

    for singleLineCommand in singleLineCommandsToDelete
        execute 'silent %s/\s*\\' . singleLineCommand . '{.*//e'
    endfor

    " Environments to delete
    for environment in environmentsToDelete
        execute 'silent %s/\\begin{' . environment . '}\_.\{-}\\end{' . environment . '}.\{-}\n//e'
    endfor

    silent %s/\\SI{.\{-}}{.\{-}}/10 meters/ge
    silent %s/\\si{.\{-}}/meters/ge
    silent %s/\\ref{.\{-}}/1/ge
    "
    " Remove all comments
    silent %s/\(\\\)\@<!%.*//e

    for commandToLeaveInnerText in surroundingCommandsToLeaveInnerText
        execute 'silent %s/\\' . commandToLeaveInnerText . '{\(.\{-}\)}/\1/ge'
    endfor

    " Replace quotes. 
    silent %s/``/"/ge
    silent %s/''/"/ge

    " Remove degree Farenheits
    silent %s/\V\\(^\\{\?circ}\?\\)/�/ge

    silent %s/\\&/\&/ge
    silent %s/\\%/%/ge
    silent %s/\\figref{}/Figure/ge
    silent %s/\\tableref{}/Table/ge
    silent %s/\\eqreftext{}/Equation/ge

    silent %s/\v\\\(\s*\\pm\s*\\\)/plus or minus /ge


    " Replace in-line equations with singular proper noun.
    silent %s/\V\\(\_.\{-}\\)/Mitch/ge
    " Replace single line commands.
    silent %s/^\s*\\\S\+{.*}\s*$//e

    "Add space between \item elements.
    silent %s/\\item\_.\{-}\ze\(\n\n\|\\item\)/\0\r/e
    silent %s/\\item/1./e

    " If the cite is at the end of the line, except if 'in ' is before it, remove it
    silent %s/\(in \)\@<!\\cite{.\{-}}\s*\././ge
    " Else replace with name
    silent %s/\\cite{.\{-}}/Paulus/ge


    " Join all the lines together.
    silent setlocal tw=9999
    silent normal! gggqG

    " Remove indentation from \item's
    silent %s/^\s*//e
    " Delete all empty lines
    silent g/^\s*$/d

    " Change current directory back.
    silent execute "cd " . fnameescape(previousWorkingDirectory)

    "write new text file.
    silent w
    " Change back to original buffer.
    silent execute "buffer " . currentFileNameWithExt

    " Reset to the last searched term and 'a' register.
    let @/ = previousLastSearch
    let @a = previousARegister

    echom "Finished transformed tex to text document."
endfunction

nnoremap <silent> <leader>ttt :<c-u>call <SID>RunTexToText()<cr>
