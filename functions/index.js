const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// Function to add a product
exports.addProduct = functions.https.onRequest(async (req, res) => {
    if (req.method !== 'POST') {
        return res.status(405).send('Method Not Allowed');
    }
    
    const { name, price, stock } = req.body;

    if (!name || !price || !stock) {
        return res.status(400).send('Missing product details');
    }

    try {
        const productRef = await admin.firestore().collection('products').add({
            name,
            price,
            stock,
            createdAt: admin.firestore.FieldValue.serverTimestamp()
        });
        res.status(201).send(`Product added with ID: ${productRef.id}`);
    } catch (error) {
        console.error('Error adding product:', error);
        res.status(500).send(`Error adding product: ${error.message}`);
    }
});

// Function to process an order
exports.processOrder = functions.https.onRequest(async (req, res) => {
    if (req.method !== 'POST') {
        return res.status(405).send('Method Not Allowed');
    }
    
    const { userId, items } = req.body;

    if (!userId || !items || !Array.isArray(items)) {
        return res.status(400).send('Invalid order details');
    }

    try {
        const orderRef = await admin.firestore().collection('orders').add({
            userId,
            items,
            status: 'pending',
            createdAt: admin.firestore.FieldValue.serverTimestamp()
        });
        res.status(201).send(`Order processed with ID: ${orderRef.id}`);
    } catch (error) {
        console.error('Error processing order:', error);
        res.status(500).send(`Error processing order: ${error.message}`);
    }
});

// Function to authenticate users
exports.authenticateUser = functions.https.onRequest(async (req, res) => {
    if (req.method !== 'POST') {
        return res.status(405).send('Method Not Allowed');
    }
    
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).send('Missing email or password');
    }

    try {
        const userRecord = await admin.auth().getUserByEmail(email);
        // Simple password check (not secure in production, use Firebase Authentication in practice)
        if (userRecord.password === password) {
            res.status(200).send('User authenticated');
        } else {
            res.status(401).send('Invalid credentials');
        }
    } catch (error) {
        console.error('Error authenticating user:', error);
        res.status(500).send(`Error authenticating user: ${error.message}`);
    }
});

// Function to get product details
exports.getProduct = functions.https.onRequest(async (req, res) => {
    const productId = req.query.id;

    if (!productId) {
        return res.status(400).send('Missing product ID');
    }

    try {
        const productDoc = await admin.firestore().collection('products').doc(productId).get();
        if (!productDoc.exists) {
            return res.status(404).send('Product not found');
        }
        res.status(200).send(productDoc.data());
    } catch (error) {
        console.error('Error fetching product:', error);
        res.status(500).send(`Error fetching product: ${error.message}`);
    }
});
