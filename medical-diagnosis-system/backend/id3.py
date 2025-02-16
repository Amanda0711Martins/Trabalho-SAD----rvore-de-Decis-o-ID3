import numpy as np
from collections import Counter

class Node:
    def __init__(self, feature=None, value=None, children=None, label=None):
        self.feature = feature
        self.value = value
        self.children = children if children else {}
        self.label = label

def entropy(y):
    counts = np.bincount(y)
    probabilities = counts / len(y)
    return -np.sum([p * np.log2(p) for p in probabilities if p > 0])

def information_gain(X, y, feature):
    base_entropy = entropy(y)
    values, counts = np.unique(X[:, feature], return_counts=True)
    weighted_entropy = sum((counts[i] / np.sum(counts)) * entropy(y[X[:, feature] == v]) for i, v in enumerate(values))
    return base_entropy - weighted_entropy

def best_feature_to_split(X, y):
    gains = [information_gain(X, y, feature) for feature in range(X.shape[1])]
    return np.argmax(gains)

def id3(X, y, features):
    if len(set(y)) == 1:
        return Node(label=y[0])
    if len(features) == 0:
        return Node(label=Counter(y).most_common(1)[0][0])

    best_feature = best_feature_to_split(X, y)
    node = Node(feature=features[best_feature])
    unique_values = np.unique(X[:, best_feature])

    for value in unique_values:
        subset_indices = X[:, best_feature] == value
        X_subset, y_subset = X[subset_indices], y[subset_indices]
        node.children[value] = id3(X_subset, y_subset, np.delete(features, best_feature))

    return node

def train_id3(training_data):
    X = np.array([[s['intensity'] for s in training_data]])
    y = np.array([s['disease_id'] for s in training_data])
    features = np.array([s['symptom_id'] for s in training_data])
    return id3(X, y, features)

def predict_disease(training_data, symptoms):
    tree = train_id3(training_data)
    return predict(tree, np.array(symptoms))
