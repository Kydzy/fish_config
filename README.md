# Fish Config — Kydzy

Configuration personnalisée de Fish, conçue pour être portable entre différentes machines Linux.

## Fonctionnalités

- Prompt personnalisé Navy & White
- Détection automatique du nom d'utilisateur
- Chemin raccourci automatiquement
- Informations Git détaillées :
  - Branche actuelle
  - Commits en avance et en retard
  - Fichiers modifiés
  - Fichiers ajoutés
  - Fichiers non suivis
  - Conflits
- Indicateur de réussite ou d'échec de la dernière commande
- Couleurs personnalisées
- Aucun plugin de prompt nécessaire

## Prérequis

- Fish
- Git

## Installation

Cloner le dépôt :

```fish
git clone git@github.com:Kydzy/fish_config.git ~/fish-config
```

Entrer dans le dossier :

```fish
cd ~/fish-config
```

Lancer l'installation :

```fish
./install.fish
```

Redémarrer Fish pour appliquer la configuration.

## Mise à jour

Depuis le dossier du dépôt :

```fish
git pull
./install.fish
```

## Structure

```text
fish-config/
├── functions/
│   └── fish_prompt.fish
├── install.fish
└── README.md
```

## Personnalisation

Les couleurs et les éléments du prompt sont configurés directement dans :

`functions/fish_prompt.fish`

Le nom d'utilisateur est automatiquement récupéré depuis la machine.