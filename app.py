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

@app.route('/tenant') 
def tenant(): 
    cursor.execute("SELECT * FROM m_tenant") 
    data = cursor.fetchall() 
    return render_template('tenant.html', tenants=data)

# TENANT CRUD
@app.route('/add_tenant', methods=['GET', 'POST']) 
def add_tenant(): 
    if request.method == 'POST': 
        name = request.form['name'] 
        phone = request.form['phone'] 
        address = request.form['address'] 
        emergency_contact = request.form['emergency_contact'] 
        
        sql = """ 
        INSERT INTO m_tenant(name, phone, address, emergency_contact) 
        VALUES (%s,%s,%s,%s) 
        """ 
        
        values = (name, phone, address, emergency_contact) 
        
        cursor.execute(sql, values) 
        db.commit()
        
        return redirect('/tenant') 
    
    return render_template('add_tenant.html')

@app.route('/edit_tenant/<int:id>', methods=['GET', 'POST']) 
def edit_tenant(id):
    if request.method == 'POST': 
        name = request.form['name'] 
        phone = request.form['phone'] 
        address = request.form['address'] 
        emergency_contact = request.form['emergency_contact']
         
        sql = """ 
        UPDATE m_tenant SET name=%s, phone=%s, address=%s, emergency_contact=%s 
        WHERE tenant_id=%s 
        """
        
        values = (name, phone, address, emergency_contact, id) 
        cursor.execute(sql, values) 
        db.commit() 
        
        return redirect('/tenant') 
    
    cursor.execute("SELECT * FROM m_tenant WHERE tenant_id=%s", (id,)) 
    tenant = cursor.fetchone() 
    
    return render_template('edit_tenant.html', tenant=tenant)

@app.route('/delete_tenant/<int:id>') 
def delete_tenant(id): 
    cursor.execute("DELETE FROM m_tenant WHERE tenant_id=%s", (id,)) 
    db.commit() 
    
    return redirect('/tenant')