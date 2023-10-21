# Deano - A decentralised annotation platform


## Introduction

Authenticity and Quality of Data used for training Machine Learning models is a major concern in the industry. 
We often have to blindly trust the data provided by centralized data providers and there is no way to verify the authenticity of the data.


Deano tries to solve this problem by providing a transparent and decentralized platform for data annotation.
Vendors can upload their data to the platform and request for annotations. Each annotation request is verified by the community and the data is annotated by the community. Each member is given a fixed payout every month for their contribution to the platform based on a reputation metric for each individual.

## Architecture

![Alt text](<Deano.png>)


## How our platform works

### Actors 

- **Vendors** - Vendors are the people who upload their data to the platform and request for annotations. 
- **Annotators** - Annotators are the people who annotate the data uploaded by the vendors.


### Workflow

1 - Vendors upload their data to the platform and request for annotations.
2 - Annotators verify the authenticity of the data and annotate the data.
3 - Annotators are rewarded for their contribution to the platform based on a reputation metric for each individual.

### How Accuracy is maintained

The accuracy of the annotations is maintained by a reputation aggregation system. Each annotator has a reputation score which is calculated based on the accuracy of the annotations done by the annotator.

Multiple annotators annotate the same data. These annotations are aggregated and checkout for majority vote. The annotators who have the same annotations as the majority are rewarded with a reputation score. The annotators who have different annotations are penalized with a negative reputation score.

By Game Theory, we can prove that we can go forward with this optimistic assumption that the majority of the annotators will be honest and will annotate the data correctly and there will be a few annotators who will try to cheat the system due to the design of the reputation system.

### How Annotators are rewarded

Each annotator will be rewarded based on the reputation score. The reputation score is calculated based on the accuracy of the annotations done by the annotator. The reputation score is calculated using the following formula.

```
Reputation Score = (Number of correct annotations - Number of incorrect annotations) / (Number of correct annotations + Number of incorrect annotations)
```

This score is continuously updated as the annotator annotates more data. The reputation score is used to calculate the payout for each annotator. The payout is calculated using the following formula.

```
Payout = Reputation Score * Base Payout
```

