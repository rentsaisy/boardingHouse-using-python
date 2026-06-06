from flask import Flask, render_template, request, redirect 
import mysql.connector 

app = Flask(__name__)
 
db = mysql.connector.connect( 
    host="localhost", 
    user="root", 
    password="", 
    database="boardinghouse_db" 
)

cursor = db.cursor(dictionary=True) 

# HOME 
@app.route('/')
def index(): 
    return render_template('index.html')