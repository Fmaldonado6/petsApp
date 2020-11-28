export class User {
    id: string;
    profilePictureId: string;
    name: string;
    email: string;
    age: number;
    gender: number;
    profilePicture: Picture;
    password: string;
    pets: Pet[];
}

export class Picture {
    id: string;
    ownerId: string;
    petId: string;
    picture: string;
    owner: User;
    pet: Pet;
    comments: Comment[]
}

export class Report{
    id:string;
    petId:string;
    userId:string;
    username:string;
    petname:string;
    pictureId:string;
    picture:string;
}

export class Pet {
    id: string;
    ownerId: string;
    name: string;
    profilePictureId: string;
    breed: string;
    type: string;
    description: string;
    age: number;
    likes: number;
    dislikes: number;
    gender: number;
    pictures: Picture[];
    profilePicture: Picture;
    owner: User;
}

export class Comment {
    id: string;
    userId: string;
    pictureId: string;
    user: User;
    picture: Picture;
}