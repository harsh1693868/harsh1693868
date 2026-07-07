#!/usr/bin/env python
# coding: utf-8

# In[10]:


from sklearn.linear_model import LinearRegression
import numpy as np

# Training data
X = np.array([[1], [2], [3], [4]])
y = np.array([2.5, 3.5, 5.0, 7.5])

# Create and train the model
model = LinearRegression()
model.fit(X, y)

# Make predictions
predictions = model.predict([[5]])
print(f"Prediction for input 5: {predictions[0]}")
    


# In[ ]:





# In[ ]:




