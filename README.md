# :sunny: PrevisionMeteoTours :cloud:

## Présentation données
Le jeu de données choisis est **météorologique**, nous souhaitons prévoir la température du lendemain en fonction des autres variables quantitative. 

Ce jeu de données a été obtenu dans les **opens data** de la ville de Tours, le fichier est trouvable [ici](https://data.tours-metropole.fr/explore/dataset/observation-meteorologique-historiques-tours-synop/export/?sort=date).

D'après l'hébergeur les paramètres atmosphériques sont **mesurés** (température, humidité, direction et force du vent, pression atmosphérique...) ou **observés** (description des nuages, visibilité...) depuis la surface terrestre.

Nous avons cependant une limite à notre analyse.
Puisque l'ensemble de ces observations est tirés d'**une seule station** d'observation.

<img src="images/Data_Location.png" width="350" height="200">


Après lecture de la colonne Date, les données sont collectées de 2017 jusqu'à maintenant, il en résulte plus de **30k observations** & **86 variables**.
***
## DATA Preparation
**_Bilan des problématiques rencontrés avec le jeu de données et leurs résolutions._**
<dl>
  <dt>Le nombre de variables est très important, les données qualitatives ou manquantes empêchent d'effectuer une régression</dt>
  <dd>On résume les données pour identifier les qualitatives et les supprimer.</dd>
  
  <dt>Les données manquantes empêche d'effectuer une régression</dt>
  <dd>On sélectionne les lignes avec une variables manquantes et on les supprime.</dd>
  
  <dt>Si l'on supprime  ces variables, les données seront nulle</dt>
  <dd>On décide de préalablement supprimés les variables avec des manquants.</dd>

  <dt>Une fois les variables avec des manquants supprimés, les données restantes n'expliquent rien, la régression associée a un R²     proche de 0</dt>
  <dd>On regarde combien de manquants sont présents par variables, on classe par ordre décroissant les variables selon leur nombre de manquants, puis on supprime petit à petit les variables pour avoir le bon équilibre entre variables explicatives et nombre d'observations.</dd>
  
  <dt>Nous souhaitons réaliser une prévision de la température à la prochaine observation, mais cette variable n'est pas présente</dt>
  <dd>Création de cette variable par utilisation de la méthode lag.</dd>
  
  <dt>Le modèle a un R² proche de 0 car les données ne sont pas ordonnées chronologiquement</dt>
  <dd>On ordonne selon la variable Date</dd>
  
  <dt>Les prédictions donnent de mauvais résultat, car les observations n'ont pas les même écarts temporelles entre elles, en effet certains jours il y a 0 observation, tandis que d'autres il y a 15.</dt>
 <dd>On associe à un id à chaque jour en isolant les parties de la variable date puis en effectuant le calcul jour + 30 x mois + 365 x année, ainsi chaque observation a désormais l'id de son jour. Ensuite on ne garde que la première observation de chaque id, il ne reste plus qu’une observation par jour.</dd>
</dl>

Après nétoyage, nous avons **1655 observations de 21 variables**, cela est suffisant pour la régression multiple.

***
## Model Building

Nous allons effectuer plusieurs régressions pour essayer d’expliquer la température en fonction des autres variables explicatives.

|R² ajusté obtenu | Modèle|
|---------|-------|
|0.67 | Régression avec toutes les variables     |
|0.60 | Régression avec variables significatives |
|0.67 | Régression forward                       |
|0.67 | Régression backward                      |
|0.67 | Régression sur ACP                       |
|0.67 | Régression Ridge                         |
|0.67 | Régression Lasso                         |

___
***
## Model Validation
![](images/Rcarre.png)

Nous allons utiliser le **R² ajusté** pour comparer les différentes régressions. Cette mesure indique la proportion de la variance expliquée par le modèle.

* 0 % le modèle n’explique par la variable Y
* 100 % le modèle explique la variabilité de Y lié à la liaison linéaire des variables explicatives entièrement


La régression avec toutes les variables obtient un R² de **0.67**, lorsque nous essayons d’obtenir une régression “presque aussi bien” en retirons les variables les moins explicatives, le **R² chute à 0.60**.

Ensuite, en utilisant les méthodes de **protection de la régression**, nous obtenons le même R² avec les régressions forward,backward,sur ACP, Ridge que avec la régression avec toutes les variables. Nous voyons l’efficacité de ces méthodes.

Nous pensons que les **contraintes du jeu de données** ont beaucoup influé : les jours où il n’y a aucune observation ne sont pas négligeables ainsi que la sélection de la première observation par jour ne rend pas compte de l’ensemble de toutes les données de la journée.
Ceci est Confirmé par l’ **Anova**.

De plus, nous estimons que nos modèles ne tiennent pas en compte la tendance et la saisonnalité (nos données sont chronologiques).

Nous ajouterons prochainement un modèle plus adapté à notre problématique, tel le modèle de Buys Ballot.
***
## Conclusion :snowflake:

**En partant d’une base open-source non construit pour cet effet, nous avons réussis à prédire (à notre échelle) la température du jour suivant en l’exprimant linéairement par rapport à un ensemble de variables explicatives.** 



