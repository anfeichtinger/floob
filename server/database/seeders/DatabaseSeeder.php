<?php

namespace Database\Seeders;

use App\Enums\AccessibilityEntry;
use App\Models\AccessibilityData;
use App\Models\AccessibilityDataReport;
use App\Models\Location;
use App\Models\Review;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Collection;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $users = User::factory(3)->create();

        $this->createFhJoanneum($users);
    }

    public function createFhJoanneum(Collection $users): void
    {
        // Create the location
        $location = Location::factory(1)->create([
            'overpass_id' => 37064372,
            'latitude' => 47.0690121,
            'longitude' => 15.4062616,
            'name' => 'FH Joanneum',
            'website' => 'https://www.fh-joanneum.at/',
            'image_url' => 'https://commons.wikimedia.org/wiki/Special:FilePath/Logo_FHJ_rgb.jpg',
        ]);

        // Create some reviews for the location
        Review::factory(1)->create([
            'location_id' => $location->first()->id,
            'user_id' => $users->random()->id,
            'score' => 5,
            'text' => 'Die FH Joanneum setzt große Schritte im Bereich Barrierefreiheit. Moderne Gebäude mit Aufzügen und Rampen sowie eine inklusive Lernumgebung schaffen eine angenehme Atmosphäre für alle Studierenden. Besonders hervorzuheben ist die Unterstützung durch barrierefreie digitale Tools und Services.',
        ]);
        Review::factory(1)->create([
            'location_id' => $location->first()->id,
            'user_id' => $users->random()->id,
            'score' => 4,
            'text' => 'Die FH Joanneum punktet durch ihr Engagement für Barrierefreiheit, sowohl in der Infrastruktur als auch im Studienalltag. Veranstaltungen und Lernmaterialien werden zunehmend inklusiv gestaltet, was Menschen mit unterschiedlichen Bedürfnissen entgegenkommt. Ein echtes Vorbild für andere Hochschulen!',
        ]);
        Review::factory(1)->create([
            'location_id' => $location->first()->id,
            'user_id' => $users->random()->id,
            'score' => 4,
            'text' => 'Die FH Joanneum zeigt ein hohes Bewusstsein für Barrierefreiheit. Besonders positiv fallen die barrierefreien Zugänge und der Fokus auf unterstützende Technologien auf. Die Hochschule bemüht sich, niemanden im Bildungsprozess auszuschließen.',
        ]);

        foreach (AccessibilityEntry::cases() as $entry) {
            $category = AccessibilityEntry::getCategory($entry);

            // Create accessibility data for the location
            $datas = AccessibilityData::factory(random_int(0, 5))->create([
                'location_id' => $location->first()->id,
                'user_id' => $users->random()->id,
                'category' => $category->value,
                'entry' => $entry->value,
            ]);

            // Create accessibility data reports for the location so some are considered not trusted.
            if ($datas->count()) {
                AccessibilityDataReport::factory(random_int(0, 5))->create([
                    'user_id' => $users->random()->id,
                    'accessibility_data_id' => $datas->random()->id,
                ]);
            }
        }
    }
}
