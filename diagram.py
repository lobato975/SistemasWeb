from diagrams import Cluster, Diagram
from diagrams.aws.compute import Lambda
from diagrams.aws.integration import SQS
from diagrams.aws.storage import S3
from diagrams.generic.database import SQL
from diagrams.generic.compute import Rack

with Diagram("Copyerest App", show=False):
    # Fonte de dados: Ações do usuário no aplicativo
    user = Rack("User Actions")

    with Cluster("Image Processing"):
        image_upload = Lambda("Image Upload")
        image_resize = Lambda("Image Resize")
        image_metadata = Lambda("Metadata Extraction")

    with Cluster("Event Queue"):
        event_queue = SQS("Event Queue")

    with Cluster("Data Processing"):
        categorize = Lambda("Categorize Content")
        recommend = Lambda("Recommendation Engine")
        notify = Lambda("Notification Service")

    # Armazenamento e análise
    image_store = S3("Image Storage")
    analytics_db = SQL("User Analytics DB")

    # Fluxo de eventos
    user >> image_upload >> [image_resize, image_metadata] >> event_queue
    event_queue >> [categorize, recommend, notify]
    [categorize, recommend] >> image_store
    recommend >> analytics_db
