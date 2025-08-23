# Oficiální Alpine image jako základ
FROM python:3.9-slim

# Pracovní adresář uvnitř kontejneru
WORKDIR /app

# Zkopíruj program a testy do adresáře kontejneru (. znamená adresář kontejneru)
COPY calculator.py .
COPY test_calculator.py .

# (Volitelné) spouštění testů už při buildu image:
RUN python -m unittest test_calculator.py -v

# Co se spustí po startu kontejneru
CMD ["python", "calculator.py"]
