---
layout: post
title:  Progress
permalink: /progress
project: true
project_language: Kotlin
project_language_color: "#F18E33"
project_commits: 299
project_last_commit: Oct 24, 2018
---

Progress is a simple fitness tracker for managing your weight, calories, and water intake. This project is made of both an Android client written in Kotlin along with a server component written in Java. This project is publicly available through the [Google Play Store](https://play.google.com/store/apps/details?id=com.handlerexploit.fitness) and is still in active development.

<p align="center" style="padding-top:20px;padding-bottom:20px;">
  <img src="/assets/progress/image1.png" width="24%" />
  <img src="/assets/progress/image2.png" width="24%" />
  <img src="/assets/progress/image3.png" width="24%" />
  <img src="/assets/progress/image4.jpg" width="24%" />
</p>

# Android Project Design
The architecture of this project was designed off of the [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) and [MVP patterns](http://konmik.com/post/introduction_to_model_view_presenter_on_android/). From a high level it is designed to allow decoupling of responsibility for ease of maintainability and testing purposes. An earlier pre-Kotlin version of such design can be found broken down in detail [here](https://medium.com/@scottmeschke/android-decompile-deepdive-ted-cf97267229e).

<p align="center" style="padding-top:20px;padding-bottom:20px;">
  <img src="/assets/progress/pattern_overall.png" width="40%" />
</p>

Code structure alone will not allow you to see the benefits of this pattern. Specific hard and fast rules are in place at a design guideline level to keep everything properly decoupled. Below are a few examples of such rules.

- *All entities will be immutable.*
- *All interactors will be the most ideal interface for requesting the associated entity.*
- *All presenters will know nothing of Android.*
- *All view interactions (clicks/visibility changes/ect.) will be triggered from a presenter.*
