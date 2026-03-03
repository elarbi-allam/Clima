# ☁️ WeatherApp - Mon Apprentissage iOS & Swift

Salut ! Moi c’est **Elarbi**, et voici **WeatherApp**. C'est un projet que j'ai réalisé pour mettre en pratique mes connaissances en **Swift** et explorer les fondamentaux du développement **iOS**. 

L'idée était simple : créer une application météo capable de récupérer les données en temps réel via une API, tout en gardant un code propre, modulaire et performant.

---

## 🚀 Ce que fait l'application

L'application permet de consulter la météo de deux façons :
1. **Recherche manuelle** : Tu tapes le nom d'une ville dans la barre de recherche.
2. **Géolocalisation** : En un clic, l'app récupère ta position actuelle pour te donner la météo locale grâce au GPS du téléphone.

---

## 🛠 Concepts Techniques & Architecture

Pour ce projet, je n'ai pas juste "codé des fonctions", j'ai implémenté des patterns utilisés par les professionnels. Voici ce qu'il y a sous le capot :

### 1. Le Pattern "Delegate" (Délégation)
C'est le concept central du projet. Au lieu que ma classe `WeatherManager` s'occupe directement de l'affichage, elle "délègue" cette tâche au `WeatherViewController`.
* **Pourquoi ?** Cela permet de séparer la logique réseau (récupérer les données) de l'interface utilisateur. Mon code est ainsi plus facile à maintenir et à faire évoluer.



### 2. Networking & JSON Parsing
J'utilise `URLSession` pour communiquer avec l'API OpenWeatherMap. 
* J'ai créé un modèle `Decodable` (`WeatherData`) qui permet de transformer automatiquement le JSON reçu en objets Swift utilisables. C’est propre et cela évite les erreurs de manipulation manuelle des données.

### 3. CoreLocation
L'intégration du framework `CoreLocation` m'a permis de gérer les autorisations de confidentialité de l'utilisateur et de transformer des coordonnées GPS (Latitude/Longitude) en données météo concrètes.

### 4. Computed Properties (Propriétés calculées)
Dans mon `WeatherModel`, j'utilise des propriétés calculées (comme `conditionName`). Cela me permet de convertir un simple ID numérique reçu de l'API (ex: 800) en un nom d'icône système SF Symbols (ex: "sun.max") de manière fluide et lisible.

---

## 📦 Structure du Projet

* **WeatherManager.swift** : Le moteur. Il gère les requêtes HTTP, l'URLSession et le décodage des données.
* **WeatherModel.swift** : Ma structure de données "propre" formatée spécifiquement pour l'affichage UI.
* **WeatherData.swift** : La structure technique qui reflète exactement le format JSON de l'API.
* **WeatherViewController.swift** : Le chef d'orchestre qui gère l'affichage, les interactions utilisateur et les protocoles.

---

## 💡 Ce que j'ai appris

En développant cette app, j'ai vraiment compris l'importance de la **gestion du thread principal (Main Thread)**. Quand on récupère des données sur le web, cela se fait en arrière-plan (Background). Pour mettre à jour l'écran sans faire ramer l'application, il faut impérativement revenir sur le fil d'exécution principal via `DispatchQueue.main.async`. 

C'est un projet clé dans mon parcours de futur expert Mobile !

---

## ⚙️ Comment tester ?

1. Clone le projet.
2. Obtiens une clé API gratuite sur [OpenWeatherMap](https://openweathermap.org/).
3. Remplace la clé dans `WeatherViewController.swift` :
   ```swift
   var weatherManager = WeatherManager(apiKey: "VOTRE_CLE_API")