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

# ROOM CRUD
@app.route('/room')
def room():
    cursor.execute("SELECT * FROM m_room")
    data = cursor.fetchall()

    return render_template('room.html', rooms=data)

@app.route('/add_room', methods=['GET', 'POST'])
def add_room():

    if request.method == 'POST':
        room_number = request.form['room_number']
        type = request.form['type']
        price = request.form['price']
        status = request.form['status']

        sql = """
        INSERT INTO m_room(room_number, type, price, status)
        VALUES (%s,%s,%s,%s)
        """

        values = (room_number, type, price, status)

        cursor.execute(sql, values)
        db.commit()

        return redirect('/room')

    return render_template('add_room.html')

@app.route('/edit_room/<int:id>', methods=['GET', 'POST'])
def edit_room(id):

    if request.method == 'POST':
        room_number = request.form['room_number']
        type = request.form['type']
        price = request.form['price']
        status = request.form['status']

        sql = """
        UPDATE m_room
        SET room_number=%s, type=%s, price=%s, status=%s
        WHERE room_id=%s
        """

        values = (room_number, type, price, status, id)

        cursor.execute(sql, values)
        db.commit()

        return redirect('/room')

    cursor.execute("SELECT * FROM m_room WHERE room_id=%s", (id,))
    room = cursor.fetchone()

    return render_template('edit_room.html', room=room)

@app.route('/delete_room/<int:id>')
def delete_room(id):

    cursor.execute("DELETE FROM m_room WHERE room_id=%s", (id,))
    db.commit()

    return redirect('/room')
