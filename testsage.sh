rm results/*
rm results/junit/*
cucumber -p sage
scp -r results/* kmtools.uits.iu.edu:/var/www/cucumber/