# ChromeOSFlex-CML

**Last updated**: 2025-06-28
**Source dataset**: https://support.google.com/chromeosflex/answer/11513094

This project aims to provide a machine‑readable list so scripts and services can programmatically check if a device supports ChromeOS Flex. It is **not** affiliated with Google and is maintained **manually** by contributors.

## Accessing the data

The data can be access via the following urls:

- **CSV**: https://raw.githubusercontent.com/dylanmccrimmon/ChromeOSFlex-CML/main/exports/ChromeOSFlex-CML.csv

- **JSON**: https://raw.githubusercontent.com/dylanmccrimmon/ChromeOSFlex-CML/main/exports/ChromeOSFlex-CML.json


## Pattern Syntax

The `ManufacturerPattern` and `ModelPattern` columns use simple wildcard patterns:

- **`*`** matches zero or more characters.
- Multiple patterns in a single field are separated by commas (`,`), meaning "match any of these."

**Examples:**

| Pattern        | Matches                                           |
|----------------|---------------------------------------------------|
| `10AS*`        | `10AS002PUK`, `10ASXYZ`, `10AS`                   |
| `ASUS EXPERTBOOK B1500*` | `ASUS EXPERTBOOK B1500CEAEY_B1500CEAE`, etc.      |



## Master CSV Columns

Each row in **`source/source.csv`** should include:

| Column                  | Type              | Description                                                            |
|-------------------------|-------------------|------------------------------------------------------------------------|
| `ManufacturerPattern`   | string            | Wildcard for WMI Manufacturer (e.g. `LENOVO`)                          |
| `ModelPattern`          | string            | Wildcard(s) for WMI Model (e.g. `10AS*`, `10AU*`, separated by `,`)    |
| `Status`                | enum              | `Certified` or `Decertified`                                           |
| `RuleConfirmed`         | boolean           | `True` if the pattern has been field-tested; `False` if estimated       |
| `CertifiedSinceVersion` | string or number  | ChromeOS Flex version when certified (e.g. `103`)                      |
| `EndOfSupport`          | date (YYYY-MM-DD) | Date when support ends                                                 |
| `Comments`              | string (optional) | Any additional notes                                                   |