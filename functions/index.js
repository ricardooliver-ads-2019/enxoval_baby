const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.createInitialLayette = functions.auth.user().onCreate(async (user) => {
  const db = admin.firestore();
  const userId = user.uid;

  try {
    await db.collection("users").doc(userId).set({
      email: user.email,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      isPremium: false,
    });

    const layetteRef = db.collection("layettes").doc();
    await layetteRef.set({
      userId: userId,
      globalProgress: 0,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log(`Enxoval criado para ${user.email}`);
  } catch (error) {
    console.error("Erro ao criar enxoval:", error);
  }
});
