
function fish_prompt
    # Statut de la commande precedente
    set -l last_status $status

    # ============================================================
    # PALETTE NEON - PERSONNALISEE
    # ============================================================
    set -l user_color '#1E3A5F'
    set -l separator_color '#FFFFFF'
    set -l path_color '#CBD5E1'
    set -l git_color '#2563EB'
    set -l modified_color '#A1A1AA'
    set -l added_color '#A1A1AA'
    set -l untracked_color '#A1A1AA'
    set -l success_color '#10B981'
    set -l error_color '#FF665A'

    # Utilisateur fixe
    set -l prompt_user (whoami)

    # ============================================================
    # CHEMIN RACCOURCI
    # ============================================================
    set -l path_display (string replace -- "$HOME" '~' "$PWD")
    set -l path_parts (string split '/' -- "$path_display")

    if test (count $path_parts) -gt 3
        set path_display "…/"(string join / $path_parts[-2..-1])
    end

    # ============================================================
    # UTILISATEUR
    # ============================================================
    set_color --bold $user_color
    printf '%s' $prompt_user

    # Separateur
    set_color $separator_color
    printf ' · '

    # ============================================================
    # CHEMIN
    # ============================================================
    set_color $path_color
    printf '%s' $path_display

    # ============================================================
    # INFORMATIONS GIT
    # ============================================================
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1

        # Branche actuelle
        set -l branch (command git branch --show-current 2>/dev/null)

        if test -z "$branch"
            set branch (command git rev-parse --short HEAD 2>/dev/null)
        end

        set_color $separator_color
        printf ' · '

        set_color $git_color
        printf '%s' $branch

        # Commits en avance et en retard
        set -l ahead (command git rev-list --count '@{upstream}..HEAD' 2>/dev/null)
        set -l behind (command git rev-list --count 'HEAD..@{upstream}' 2>/dev/null)

        if test -n "$ahead"; and test "$ahead" -gt 0
            printf ' ⇡%s' $ahead
        end

        if test -n "$behind"; and test "$behind" -gt 0
            printf ' ⇣%s' $behind
        end

        # Compteurs Git
        set -l modified 0
        set -l added 0
        set -l untracked 0
        set -l conflicts 0

        for line in (command git status --porcelain=v1 --untracked-files=normal 2>/dev/null)

            set -l xy (string sub -l 2 -- "$line")
            set -l x (string sub -l 1 -- "$xy")

            # Conflits
            if string match --quiet --regex '^(DD|AU|UD|UA|DU|AA|UU)$' -- "$xy"
                set conflicts (math $conflicts + 1)
                continue
            end

            # Fichiers non suivis
            if test "$xy" = '??'
                set untracked (math $untracked + 1)
                continue
            end

            # Fichiers ajoutes a l'index
            if test "$x" = A
                set added (math $added + 1)
            end

            # Modifications ou suppressions
            if string match --quiet --regex '[MD]' -- "$xy"
                set modified (math $modified + 1)
            end
        end

        # Affichage des compteurs
        if test $modified -gt 0
            set_color $modified_color
            printf ' ~%s' $modified
        end

        if test $added -gt 0
            set_color $modified_color
            printf ' +%s' $added
        end

        if test $untracked -gt 0
            set_color $modified_color
            printf ' ?%s' $untracked
        end

        if test $conflicts -gt 0
            set_color $error_color
            printf ' !%s' $conflicts
        end
    end

    # ============================================================
    # STATUT DE LA COMMANDE PRECEDENTE
    # ============================================================
    set_color $separator_color
    printf ' · '

    if test $last_status -eq 0
        set_color $success_color
        printf '✓'
    else
        set_color $error_color
        printf '✗'
    end

    # ============================================================
    # SYMBOLE DE SAISIE
    # ============================================================
    set_color --bold $user_color
    printf ' ❯ '

    set_color normal
end
