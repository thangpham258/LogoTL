#git clone https://github.com/Paperspace/DataAugmentationForObjectDetection.git

#Create New Dirs
mkdir Images/test/pickle/
mkdir Images/train/pickle/
mkdir Images/test/DA
mkdir Images/train/DA

##Convert XML Labels to CSV
# From Home Directory
cd
python xml_to_csv.py -i Images/train -o annotations/train_labels.csv
python xml_to_csv.py -i Images/test -o annotations/test_labels.csv

#Data Augmentation - Create Synthetic Training Images
#Training Set
python3 transformImages.py \
    --input_dir Images/train/ \
    --numIters 2 \
    --image_label_file annotations/train_labels.csv \
    --output_path annotations/train_labels_DA.csv \
    --label0 Cloudera \
    --label1 Hortonworks \
    --label2 ClouderaOrange

#Test Set
python3 transformImages.py \
    --input_dir Images/test/ \
    --numIters 2 \
    --image_label_file annotations/test_labels.csv \
    --output_path annotations/test_labels_DA.csv \
    --label0 Cloudera \
    --label1 Hortonworks \
    --label2 ClouderaOrange


##Convert CSV to TF-Record
# From Home Directory
cd

#Post Data Augmentation - Training Set
python3 generate_tfrecord.py \
--label0=Cloudera \
--label1=Hortonworks \
--label2=ClouderaOrange \
--csv_input=annotations/train_labels_DA.csv \
--img_path=Images/train/DA  \
--output_path=annotations/train_DA.record

#Post Data Augmentation - Training Set
python3 generate_tfrecord.py \
--label0=Cloudera \
--label1=Hortonworks \
--label2=ClouderaOrange \
--csv_input=annotations/test_labels_DA.csv \
--img_path=Images/test/DA  \
--output_path=annotations/test_DA.record