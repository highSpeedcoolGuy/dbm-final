import pandas as pd
from sqlalchemy import create_engine
import tensorflow as tf
import matplotlib.pyplot as plt

# --- Connect to PostgreSQL database ---
# Replace with YOUR database info:
db_username = 'your_username'
db_password = 'your_password'
db_host = 'localhost'  # or your server IP
db_port = '5432'       # PostgreSQL default port
db_name = 'your_database_name'

# Create the engine
engine = create_engine(f'postgresql+psycopg2://{db_username}:{db_password}@{db_host}:{db_port}/{db_name}')

# --- Load data from database ---
query = "SELECT feature_column, target_column FROM your_table;"
df = pd.read_sql_query(query, engine)

# --- Prepare data ---
X = df[['feature_column']].values  # 2D array
y = df[['target_column']].values   # 2D array

# --- Build TensorFlow Model ---
model = tf.keras.Sequential([
    tf.keras.layers.Dense(1, input_shape=(1,))
])
model.compile(optimizer='sgd', loss='mean_squared_error')
model.fit(X, y, epochs=200, verbose=0)

# --- Predict and Plot ---
y_pred = model.predict(X)

plt.scatter(X, y)
plt.plot(X, y_pred, color='red')
plt.xlabel('Feature')
plt.ylabel('Target')
plt.title('Linear Regression with TensorFlow and PostgreSQL Data')
plt.show()
