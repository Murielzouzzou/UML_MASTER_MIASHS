# Représentation des données MNIST — Apprentissage non supervisé

## Présentation du projet

Ce projet a pour objectif de visualiser et de comparer des images de chiffres manuscrits issues du jeu de données MNIST à l’aide de plusieurs méthodes de réduction de dimension.

Les images sont initialement représentées par 784 pixels. L’objectif est de les projeter dans un espace à deux dimensions afin d’observer leur organisation et de comparer les représentations obtenues.

## Méthodes utilisées

Quatre méthodes de visualisation sont étudiées :

- **ACP (Analyse en composantes principales)** : méthode linéaire qui recherche les axes expliquant le plus de variance.
- **MDS (Multidimensional Scaling)** : méthode qui cherche à préserver les distances entre les observations.
- **t-SNE** : méthode non linéaire qui met l’accent sur les voisinages locaux.
- **UMAP** : méthode de réduction de dimension qui permet de représenter les structures de voisinage des données.

## Données

Le travail porte sur les 1 000 premières images de l’échantillon d’apprentissage MNIST.

Chaque image est décrite par 784 variables correspondant aux pixels. Les chiffres de 0 à 9 sont utilisés pour colorer les points et faciliter l’interprétation des graphiques.

## Technologies et packages

- R
- RStudio
- FactoMineR
- Rtsne
- umap

## Organisation du dépôt

- `MNIST.Rdata` : données utilisées pour réaliser les analyses.
- `TP_MNIST.R` : script R contenant le code commenté des quatre méthodes.
- `Compte_rendu_MNIST.pdf` : compte rendu présentant les graphiques et leur interprétation.

*Les noms des fichiers peuvent être adaptés à ceux présents dans le dépôt.*

## Installation et utilisation

1. Installer R et, si nécessaire, RStudio.
2. Installer les packages utilisés :

   ```r
   install.packages("FactoMineR")
   install.packages("Rtsne")
   install.packages("umap")
   ```

3. Ouvrir le script `TP_MNIST.R` dans RStudio.
4. Vérifier que le fichier `MNIST.Rdata` est accessible depuis le répertoire de travail.
5. Exécuter le script pour obtenir les représentations graphiques.

## Résultats attendus

Le script produit quatre représentations en deux dimensions, une pour chaque méthode. Les couleurs correspondent aux chiffres de 0 à 9.

Les résultats permettent de comparer la manière dont les différentes méthodes représentent les données et font apparaître les regroupements visuels.

## Conclusion

Ce projet met en évidence les différences entre les méthodes linéaires et non linéaires de réduction de dimension. Les représentations obtenues montrent que le choix de la méthode et de ses paramètres influence la visualisation des images MNIST.

## Cadre du projet

Travail pratique réalisé dans le cadre du cours d’**Apprentissage non supervisé**, autour de la représentation et de la visualisation de données de grande dimension.
