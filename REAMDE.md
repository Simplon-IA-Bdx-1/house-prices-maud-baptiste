
## Organisation du projet
* Inspection du train set : 
    * [Descriptive statistics](https://github.com/Simplon-IA-Bdx-1/give-me-some-credit-Malaika-p/blob/master/ml_mastery_5_understand_your_data_with_descriptive_statistics.ipynb)
    * [Visualization](https://github.com/Simplon-IA-Bdx-1/give-me-some-credit-Malaika-p/blob/master/ml_mastery_6_understand_your_data_with_visualization.ipynb)
* Nettoyage et préparation des données :  [New features give me credit](https://github.com/Simplon-IA-Bdx-1/give-me-some-credit-Malaika-p/blob/master/new_features_give_me_credit.ipynb)
* Création des modèles et évaluation rapide sur BigMl : [Training BigML give me some credit](https://github.com/Simplon-IA-Bdx-1/give-me-some-credit-Malaika-p/blob/master/training_bigml_give_me_credit.ipynb)
* Evaluation du modèle, importance des features, ROC curve : [Evaluation du modèle](https://github.com/Simplon-IA-Bdx-1/give-me-some-credit-Malaika-p/blob/master/evaluation_bigml_give_me_credit2.ipynb)
* Prediction in the test set kaggle and submition : [Kaggle submition]()

Pour mes comparaison je me suis aidé du code de Guillaume pour simplifier. Je ne suis donc pas sûre que tu puisse Faire tourner correctement évaluation et visualisation
* comparision Ensemble and deepnet : 
    * [ensemble deepnet comparision](https://github.com/Simplon-IA-Bdx-1/give-me-some-credit-Malaika-p/blob/master/ensemble_deepnet_comparison.ipynb)
    * [ensemble deepnet comparision evaluation](https://github.com/Simplon-IA-Bdx-1/give-me-some-credit-Malaika-p/blob/master/ensemble_deepnet_comparison_evaluation.ipynb)
    * [ensemble deepnet comparision visualisation](https://github.com/Simplon-IA-Bdx-1/give-me-some-credit-Malaika-p/blob/master/ensemble_deepnet_comparison_visualisation.ipynb)

* Test xgboost  XGBClassifier : [Xgboost](https://github.com/Simplon-IA-Bdx-1/give-me-some-credit-Malaika-p/blob/master/gmsc_sklearn.ipynb)
* Exercice du 7 novembre sur une prédiction : [One prediction](https://github.com/Simplon-IA-Bdx-1/give-me-some-credit-Malaika-p/blob/master/exo_07_11_2019.ipynb)

### Nombre de features. Nombre de lignes
* Train : 11 features - 150000 lignes
* Test : 11 features - 101503 lignes

## Préparation des données de train, val et test
* split the training
* Correcting the values in monthly income Set NaN to 0 in the monthly income column
* Creating a new column for monthly debt. We calculate the monthly debt. If the income is zero, we take the monthly debt from the debt ratio.
* Correcting the values in number of dependents
* Create new colomn BalancedIncomePerDependent
* Create new colomn  BalancedIncome  MontlyIncome/ (NumberOfDependents +1)
* Weighted sum of late payments
* Replace the outlier of DebtRatio by 0.3

I tried 6 differents configurations for the features and i keep the best.



## Score kaggle
* BigMl : 
    * Score privée : 0.86454
    * Score public : 0.85878
* Xgboost :
    * Score privée 0,86633
    * Score public 0,85935

## observations sur les 100 plus grosses erreurs 

   * 100% n'ont aucuns jours de retard 
   * 75% on plus de 6 NumberOfOpenCreditLinesAndLoans
   * environ 80% ont plus de 40 ans
   * environ 60% ont plus de 50 ans 

   * 20% avait 0 en MontlyIncome et ont été corrigé à 0.3 en DebtRatio
      * Avec eux 50% sont audessus de 0.3 en DebtRatio



Trouver seuil qui optimise le gain total :
*0.29533333333333334
*Le gain maximum est 10135500

Tu dois créer les dossiers suivants : 

./predictions/'
./prep_datasets/'

## Démarrer l'environnement de développement Jupyter

Nous utiliserons un environnement Jupyter fourni par un conteneur Docker. L'image utilisée est définie par le [Dockerfile](docker/Dockerfile) fourni. Celui-ci est basé sur [handson-ml2](https://github.com/ageron/handson-ml2/tree/master/docker) et il installe les packages Python listés dans [requirements.txt](requirements.txt). Ces fichiers sont à customiser au besoin.

1. Créez un fichier `docker/auth.env` basé sur `docker/auth-sample.env`, qui contiendra vos noms d'utilisateur et clés d'API pour [BigML](https://bigml.com) et Kaggle.
2. A partir du dossier `docker/`, exécutez la commande shell:

    ```bash
    docker-compose up
    ```

3. Ouvrez votre navigateur à l'adresse qui s'affiche suite à l'exécution de la commande précédente, puis cliquez sur [Intro-Jupyter.ipynb](Intro-Jupyter.ipynb) dans la liste.

## Exploration des données

* Nombre de features. Nombre de lignes dans train ("train full") et test.
* Inspectez (sous-ensemble des) données d'apprentissage en les parcourant dans un tableur et via la visualisation en histogrammes (sous Kaggle, BigML web, ou avec pandas profiling). Que remarquez-vous? (Mentionnez noms de features et ids d'inputs notables.)
* Partage de train full en train et validation.
* Inspection du train set (histogrammes, statistiques des distributions).

## Préparation des données de train, val et test (avec [Pandas](http://pandas.pydata.org))

* Remplacement valeurs manquantes / erronées / aberrantes
* Ajouts de features

Note: vous pouvez utiliser le notebook [Intro-Pandas.ipynb](Intro-Pandas.ipynb) pour vous familiariser avec la librairie Pandas.

## Création et sélection de modèle (avec [BigML Python](http://bigml.readthedocs.io))

* Comparer AUC de `ensemble` et de `deepnet` sur les données préparées (apprentissage sur train, evaluation sur val), et choisissez la meilleure des deux techniques pour la suite.

## Analyse de modèle

### Comportement global

* Créer modèle sur train
* Regarder feature importances
* Regarder Partial Dependence Plots (via interface graphique BigML pour l'instant; plus tard: avec matplotlib ou plotly)

### Erreurs sur val set

* Téléchargement des probabilités de classe faites par le modèle, sur le dataset de validation
* Ajout de colonne d'erreur
* Calcul mesures agrégées de performance: implémenter chaque métrique en Python, puis vérifier valeurs calculées en comparant avec ce que donne BigML.
  * Métriques qui sont fonction du seuil: matrice confusion et accuracy
  * Métrique indépendante du seuil: AUC
* Export des lignes avec les 100 plus importantes erreurs
  * Inspection dans tableur. N'hésitez pas à rajouter une colonne de commentaires dans votre tableur.
  * Interprétations à noter dans le notebook (mentionner l'id de l'objet, et votre interprétation, par ex: valeurs de features anormales, etc.)
* Proposez des idées pour améliorer la préparation des données, en vous basant sur l'analyse des erreurs

## Optimisation du seuil de classification

Trouver seuil qui optimise le gain total sur le validation set, pour la matrice de gains/coûts suivante:

  | Actual / Predicted | 0 | 1 |
  |--------------------|---|---|
  | 0 | $500 | -$500 |
  | 1 | -$2500 | $0 |

## Envoi de prédictions à Kaggle

* Création d'un modèle à partir de train full
* Création des probabilités de classe sur le test set
* Envoi des prédictions à Kaggle [via Python](https://github.com/kaggle/kaggle-api)
* Essayez d'obtenir le meilleur résultat possible!

## Bonus: learning curves

* Comparez performance de “ensemble” et de “deepnet” sur val set, pour afficher des courbes (learning curves) comme à la page 11 de Machine Learning Yearning: en abscisse, pourcentage de données de train utilisées pour créer un modèle; en ordonnée, AUC du modèle créé, sur le val set.
* Afficher également la performance sur train set.

## Bonus: scikit-learn et XGBoost

* Parcourez le notebook [Intro-sklearn-xgboost.ipynb](Intro-sklearn-xgboost.ipynb) et adaptez votre code pour créer des modèles sans avoir à utiliser BigML

## Copyright

[Louis Dorard](https://www.louisdorard.com/) © 2019 - Tous droits réservés

Suivez-moi sur Twitter [@louisdorard](https://twitter.com/louisdorard)
