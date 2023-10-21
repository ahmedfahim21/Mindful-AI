'use client'
import SignUp from '@/components/Signup'
import { db } from '@/firebase/config';
import { doc, setDoc } from 'firebase/firestore';
import { v4 as uuidv4 } from 'uuid'
const addUsers = async () => {
  const users = [];
  for (let i = 1; i <= 20; i++) {
    // Generate a random year between 1995 and 2005
    const randomYear = 1995 + Math.floor(Math.random() * 11);
    // Generate a random month and day (for simplicity, we use January 1st for the day)
    const randomMonth = Math.floor(Math.random() * 12) + 1;
    const randomDay = Math.floor(Math.random() * 28) + 1;

    const conditions = ["Risky", "Good"];
    const departments = ["Computer Science", "Electrical Engineering", "Mechanical Engineering", "Civil Engineering"]

    //generate 7 random numbers which sum up to 100
    // [9 , 11,25, 10, 15, 20, 10]
    const generateEmotions = () => {
      const emotions = [];
      let sum = 0;
      for (let i = 0; i <= 6; i++) {
        const num = Math.floor(Math.random() * 15);
        emotions.push(num);
        sum += num;
      }

      return emotions;


    }



    //uuid of size 6
    const user = {
      uid: uuidv4().slice(0, 6),
      name: `Student_${i}`,
      institute: 'MIT',
      dept: departments[Math.floor(Math.random() * 4)],
      gender: i % 2 === 0 ? 'Male' : 'Female',
      dob: `${randomYear}-${String(randomMonth).padStart(2, '0')}-${String(randomDay).padStart(2, '0')}`,
      body_vitals: [{
        created_at: new Date().toISOString(),
        step_count: Math.floor(Math.random() * 10000),
        heartrate: Math.floor(Math.random() * 100) + 60,
        sleep: Math.floor(Math.random() * 10),
      }],
      status: conditions[Math.floor(Math.random() * 2)],
      video_score: Math.floor(Math.random() * 100),
      quiz_score: Math.floor(Math.random() * 100),
      audio_score: Math.floor(Math.random() * 100),
      transcript_score: Math.floor(Math.random() * 100),
      emotions: generateEmotions(),
    };
    users.push(user);
  }

  // Now, insert the users into Firebase
  for (const user of users) {
    console.log(user);
    await setDoc(doc(db, "students", user.uid), user);
  }


}



export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      {/* <SignUp />     */}


      <button onClick={addUsers}>
        Add Dummy User
      </button>


    </main>
  )
}