# ============================================================
# TP : Representation des donnees MNIST
# Objectif : comparer quatre methodes de representation
# en deux dimensions : ACP, MDS, t-SNE et UMAP
# ============================================================


# ------------------------------------------------------------
# 1. Preparation des donnees
# ------------------------------------------------------------

# Indiquer le dossier dans lequel se trouve le fichier MNIST.Rdata
setwd("C:/Users/murie/OneDrive/Documents/DOSSIER_MASTER_MIASHS_MURIEL/UML")

# Supprimer les objets deja presents dans l'environnement
rm(list = ls())

# Charger le jeu de donnees MNIST
load("MNIST.Rdata")

# Pour commencer, on utilise les 1000 premieres images
# afin de limiter le temps de calcul des methodes de visualisation.
x <- train$x[1:1000, ]

# Recuperer le chiffre correspondant a chaque image
y <- train$y[1:1000]

# Verifier le nombre d'images et le nombre de variables
# Chaque image est decrite par 784 pixels.
dim(x)

# Observer la repartition des chiffres dans cet echantillon
table(y)


# ------------------------------------------------------------
# 2. Preparation des couleurs
# ------------------------------------------------------------

# Attribuer une couleur a chaque chiffre de 0 a 9.
# On utilisera les memes couleurs pour les quatre graphiques
# afin de pouvoir comparer plus facilement les representations.
couleurs <- rainbow(10)[as.integer(as.character(y)) + 1]


# ------------------------------------------------------------
# 3. ACP : Analyse en composantes principales
# ------------------------------------------------------------

# Charger FactoMineR, qui contient la fonction PCA().
library(FactoMineR)

# Realiser l'ACP sur les 1000 images.
# scale.unit = FALSE signifie que les pixels sont centres,
# mais ne sont pas reduits a une variance egale a 1.
# graph = FALSE evite l'affichage automatique des graphiques.
res.pca <- PCA(x, scale.unit = FALSE, graph = FALSE)

# Recuperer les coordonnees des images sur les deux premiers axes.
# Chaque point correspond a une image MNIST.
coord.pca <- res.pca$ind$coord[, 1:2]

# Afficher les images dans le plan forme par les deux premiers axes.
# Les couleurs indiquent le chiffre associe a chaque image.
plot(
  coord.pca[, 1],
  coord.pca[, 2],
  col = couleurs,
  pch = 19,
  cex = 0.6,
  xlab = "Composante principale 1",
  ylab = "Composante principale 2",
  main = "ACP des images MNIST"
)

# Ajouter la legende pour identifier les chiffres.
legend(
  "topright",
  legend = 0:9,
  col = rainbow(10),
  pch = 19,
  title = "Chiffre",
  cex = 0.7
)

# Afficher la variance expliquee par les axes de l'ACP.
# Cela permet de mesurer la part de variance conservee
# par chacune des composantes principales.
res.pca$eig


# ------------------------------------------------------------
# 4. MDS : positionnement a partir des distances
# ------------------------------------------------------------

# Calculer les distances euclidiennes entre les images.
# La distance compare ici les valeurs des pixels des images.
distances <- dist(x)

# Realiser un MDS classique en deux dimensions.
# cmdscale cherche une representation qui preserve au mieux
# les distances entre les images.
res.mds <- cmdscale(distances, k = 2)

# Afficher la representation obtenue avec le MDS.
plot(
  res.mds[, 1],
  res.mds[, 2],
  col = couleurs,
  pch = 19,
  cex = 0.6,
  xlab = "Dimension 1",
  ylab = "Dimension 2",
  main = "MDS des images MNIST"
)

# Identifier les chiffres grace aux couleurs.
legend(
  "topright",
  legend = 0:9,
  col = rainbow(10),
  pch = 19,
  title = "Chiffre",
  cex = 0.7
)


# ------------------------------------------------------------
# 5. t-SNE : representation des voisinages locaux
# ------------------------------------------------------------

# Charger le package Rtsne.
library(Rtsne)

# Fixer la graine aleatoire pour rendre le calcul reproductible.
set.seed(123)

# Representer les images en deux dimensions avec t-SNE.
# perplexity = 30 regle la taille du voisinage pris en compte
# par la methode.
# check_duplicates = FALSE evite le controle des doublons exacts.
res.tsne <- Rtsne(
  x,
  dims = 2,
  perplexity = 30,
  check_duplicates = FALSE
)

# Recuperer les coordonnees obtenues avec t-SNE.
coord.tsne <- res.tsne$Y

# Afficher la representation t-SNE.
plot(
  coord.tsne[, 1],
  coord.tsne[, 2],
  col = couleurs,
  pch = 19,
  cex = 0.6,
  xlab = "Dimension 1",
  ylab = "Dimension 2",
  main = "t-SNE des images MNIST"
)

# Ajouter la legende des chiffres.
legend(
  "topright",
  legend = 0:9,
  col = rainbow(10),
  pch = 19,
  title = "Chiffre",
  cex = 0.7
)


# ------------------------------------------------------------
# 6. UMAP : autre methode de representation en deux dimensions
# ------------------------------------------------------------

# Charger le package umap.
library(umap)

# Fixer la graine aleatoire pour rendre le calcul reproductible.
set.seed(123)

# Partir de la configuration par defaut d'UMAP.
config <- umap.defaults

# Regler le nombre de voisins pris en compte par la methode.
# Une petite valeur privilegie davantage les structures locales.
config$n_neighbors <- 15

# Regler la distance minimale entre les points dans la representation.
# Cette valeur influence la compacite des groupes formes.
config$min_dist <- 0.1

# Realiser UMAP sur les images MNIST.
res.umap <- umap(x, config = config)

# Recuperer les coordonnees des images dans le plan UMAP.
coord.umap <- res.umap$layout

# Afficher la representation UMAP.
plot(
  coord.umap[, 1],
  coord.umap[, 2],
  col = couleurs,
  pch = 19,
  cex = 0.6,
  xlab = "Dimension 1",
  ylab = "Dimension 2",
  main = "UMAP des images MNIST"
)

# Ajouter la legende pour identifier les chiffres.
legend(
  "topright",
  legend = 0:9,
  col = rainbow(10),
  pch = 19,
  title = "Chiffre",
  cex = 0.7
)


# ------------------------------------------------------------
# 7. Fin du TP
# ------------------------------------------------------------

# Les quatre representations permettent de comparer
# differentes facons de projeter les images MNIST en deux dimensions.
# Les resultats dependent de la methode et de ses parametres.
# Les graphiques seront interpretes et compares dans le compte rendu.

