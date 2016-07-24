# NameToFaces
Repo following Project 10: Names to Faces with UICollectionView tutorial at www.hackingwithswift.com.  The goal of this project is to build an app that helps you remember names with the person's face and learning UICollectionView in the process.

![App Screenshot](Project10-AppScreenshot.png)

## Concepts Learned/Practiced
* UICollectionView
  * Adding ```UICollectionViewDataSource``` and ```UICollectionViewDelegate``` protocols to the ViewController class
* Creating custom classes
  * Created PersonCell and Person custom classes
* ```UIImagePickerController``` class
* Using ```NSUUID``` object's ```UUIDString``` method to create a unique ID name
* Saving image to JPEG and writing to disk.
* Initializer method to create instances of a class
  * Example from project:

    ```swift
    init(name: String, image: String) {
      self.name = name
      self.image = image
    }
    ```

## Attributions
[Project 10: Name to Faces with UICollectionView](www.hackingwithswift.com/read/10/overview)
